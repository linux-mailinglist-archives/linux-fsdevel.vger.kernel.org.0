Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA73115F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhBEWq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhBENds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:33:48 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75542C0613D6;
        Fri,  5 Feb 2021 05:33:00 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id b187so6705153ybg.9;
        Fri, 05 Feb 2021 05:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hws2a3q+IvIq2Tq4/ndL6OgkHoz5S/vLO/ZmY8diyq0=;
        b=DwIRcm9AZ5sbrGU6NRZrg/q6F7eXpuTxZKwTdLL/pqUlLtWGQ54a8JOK/eRDEWqF6o
         lDwr91+yNOYEFvmOVH7ugp8qZqnGbeEULsoBLzXmtVVbSxj47VHX9IFLGWqktff7Mtcc
         zkTrwwNuamH5PIk1dHoYOhfveEDbtToJkbvvaSIIRZKkjF+xEr8kN4KP9HrUUYYfWCTA
         r/XGnqwbOuV6xREMfqxpp9+FNOIpS8WsqNjxrN1xn3k8MPn4klSDfekN25PWqgZ4jRNB
         Xto8Ic1nYDTZONWnx/fHASbVnM2dbjDdlPWGl7PnvDe0UOBHYsyMYvi5mQB4mVr+0Ar3
         h2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hws2a3q+IvIq2Tq4/ndL6OgkHoz5S/vLO/ZmY8diyq0=;
        b=DIzvUSOKFowhbKOfsj5oTZfbnLA8FugZ+CsaYFl7v6ntpEmD7T+SbtwEn3l45/26X/
         cLLnWy68sWPqJdxsn5m31Ru/dJRLGgb1L6ReD2uTN0+CDvY5cx+N1cXOhYBxvs6KaRiA
         7G7XSgFtHxYijPC0AT6FBwC8r7bMOneLSBSDQoS7/XW0khfZ6jNNISRuSDsphmMA+stn
         7ANMa2VYiGVEhe3gNd38NcmQxj6YsctoNXx4PCKXZVydTV9Eu9A2o+ipkpUoI+om4KKn
         mTM4usyl7eWfIY3/daMLAscM4Ck4IUnXeDa5mbF85pbDCwfcWNcV8NGz+EP6gaQPzETt
         ujCg==
X-Gm-Message-State: AOAM531szyRm2Iw9hwikLG5/ISAgIU8cIWbn2hmWvvMpkX3KI4Q3wOMP
        p/nSrVvT4eDaQgvSe1wPI2vJmyxijIg3P5U+a4DN0h2byxg=
X-Google-Smtp-Source: ABdhPJzBjZLjiR9WM0iOiyZxvFk7Oium5eg2lgy/A1BmZAnI54rDhPGu0WgYmIjpuSKp6Y1QgT8ec65ZTbSMlfoeZdI=
X-Received: by 2002:a25:1646:: with SMTP id 67mr6506637ybw.97.1612531979586;
 Fri, 05 Feb 2021 05:32:59 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
 <20210202174255.4269-1-aaptel@suse.com> <CANT5p=qpnLH_3UrOv9wKGbxa6D8RUSzbY+uposEbAeVaObjbHg@mail.gmail.com>
 <87o8h28gjb.fsf@suse.com>
In-Reply-To: <87o8h28gjb.fsf@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Fri, 5 Feb 2021 05:32:48 -0800
Message-ID: <CANT5p=o4b9RfQ5omd911pLH3WFbiC1-ghF43kRZ5-4SV+PeS=g@mail.gmail.com>
Subject: Re: [PATCH v3] cifs: report error instead of invalid when
 revalidating a dentry fails
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Aur=C3=A9lien,

xfstest 070 was failing today with this patch.
It looks like we need to handle ESTALE here, in addition to ENOENT.
ESTALE happens when the file type or inode number has changed on the
server, which indicates that it's a new entry.

Regards,
Shyam

On Tue, Feb 2, 2021 at 10:34 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote=
:
>
> Shyam Prasad N <nspmangalore@gmail.com> writes:
> > This looks good to me.
> > Let me know if you get a chance to test it out. If not, I'll test it
> > on my setup tomorrow.
>
> I've done some tests: the reproducer cannot trigger the bug, accessing a
> deleted file invalidates, accessing an existing file revalidates. It look=
s
> ok.
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)
>


--=20
Regards,
Shyam
