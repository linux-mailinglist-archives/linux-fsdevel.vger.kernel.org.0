Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD3197972
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgC3KmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 06:42:15 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44057 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgC3KmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:42:15 -0400
Received: by mail-il1-f194.google.com with SMTP id j69so15231711ila.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2020 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJuuvPfcofORz5IwiTa+dZhDbd/mN53TYOe69bGhZJ8=;
        b=tjvPVwPEqlQQRR6RU7mOI79fROX9QPmSrOL5C5CZSGkJ+uHB67QPUZjnLHSEj2Tka/
         89V1gAL5pXTlUvgaSEYtrY6PzrRUYLDlWOja61Uc+i+OurQ1Fsp6Sy9WyCmAj2OS8uoi
         pv1ZL8v/YKJ/cciy3aDnhIO8MEK22QrhTHv+wfZXgc68zqPy425WWpD/UymSkxp6XpsQ
         M+yXnm4kNo5fZlzDOCMxyyP/4B0JzLS6Oe50VcGE6zc1HsnwNJulUKCdtYvqlvYAzW2P
         BLcru3vwCUOl8kn/4Tq1gVOiZgTmRpxCmN5i1lfmOaqYkWWTsrHDJwMqoJlpd3zlY7SI
         D8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJuuvPfcofORz5IwiTa+dZhDbd/mN53TYOe69bGhZJ8=;
        b=W6odgokhGO2yIWJion3+1Wd9qdRXCCOqaHgoyYWcqUXluf2fKrLX4dLMzgqVkIbMwj
         r/adezjQYEnnMJLq/FI0bTFZTfE/u+jzkbA5qwQNmb0P4JyXH1N4qV6CvcQ0vOZQBsre
         QBXI4Kt8Pb+KrbQ89vNar1qOvv3cTBvWSUZkM5uygELNawBLkfsWQm5HAks8m+vQ0J3S
         2ccdfQ4K1Xt5D5OuJhQkr0dMV/j6zsBZ+5uXW9QN9qpknzF5kB7o+5w9BCYDUseszubK
         5RFytDwquq0fhx8L6SLhig04k6chJC8lSvs38SBk2G7ofyWWPpS17DnKgK3AzqPgzybZ
         cuYQ==
X-Gm-Message-State: ANhLgQ0uvby0JMG96+lelxA24wCrI5FvhQX/aGKYKhIT+xslxzy/7d5s
        f1v/Zz9B0+fJu/oQqAMKU9N62q5LZpKGk2c7sjdOqg==
X-Google-Smtp-Source: ADFU+vuuXHiDkSU6yhUWgNTZaL4hYcZWjoHNuABTDylnuAZ1MFW4bkkKn9RA/+RlskrMSQhwhcABUU3GA5W0iq75DnI=
X-Received: by 2002:a05:6e02:68a:: with SMTP id o10mr10879050ils.72.1585564934270;
 Mon, 30 Mar 2020 03:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151022.31456-1-amir73il@gmail.com> <20200319151022.31456-11-amir73il@gmail.com>
 <20200324175029.GD28951@quack2.suse.cz> <CAOQ4uxhh8DJC+5xPjGaph8yKXa_hSxi7ua0s3wUDaV7MPcaStw@mail.gmail.com>
 <20200325092707.GF28951@quack2.suse.cz>
In-Reply-To: <20200325092707.GF28951@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 30 Mar 2020 13:42:03 +0300
Message-ID: <CAOQ4uxi8idvhgs0Uu96t=h5B=K71-79mnOGEGuaifitvvpo_2g@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] fanotify: divorce fanotify_path_event and fanotify_fid_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> Ah, right. Thanks for clarification. Actually, I think now that we have
> fanotify event 'type' notion, I'd like to make overflow event a separate
> type which will likely simplify a bunch of code (e.g. we get rid of a
> strange corner case of 'path' being included in the event but being
> actually invalid). Not sure whether I'll do it for this merge window,
> probably not since we're in a bit of a hurry.
>

Jan,

I went a head and did those 2 cleanups you suggested to
fanotify_alloc_event(). pushed result to fsnotify-fixes branch.
Probably no rush to get those into this merge window.
For your consideration.

Thanks,
Amir.
