Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3446A1437B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 08:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAUHfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 02:35:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33876 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAUHfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:35:34 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so1837443iof.1;
        Mon, 20 Jan 2020 23:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+F7l/MWFQgRxyHbpRyxJbIOirQMGsQvf8nzkFjt7rtU=;
        b=OR25Qdq8m/jH+8shuXB7H0qmJwDh0jA3QVqleA6KUHmUJlCojHBr1gSEdR/Ggnndkn
         I66NHwDEL9K3x8CmAcWUFqAtiqFyZS+7I7+fNUUZude6f5ORPd3iF9inPDySGno/i9aX
         QphklD173cya/A5w/hT8AvCqpHJuqM76Jj+3Djop8mUiCLs5sW8nwwWLQ29+XxiR2ZUK
         5NqY/NpdbFNaEEQju9S35xMo30Y83+j3attZojXPLP0Sthc2AGVFZ36n5RTDe6Ht0LF1
         mc30vgBlku54nelUozGOl9f70N9wujXjnwYNVFrpiZ2HSbT9018O2NGjoJ1E0xEEVZAG
         oQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+F7l/MWFQgRxyHbpRyxJbIOirQMGsQvf8nzkFjt7rtU=;
        b=D1SeQ9TC0Pz8fH6en000GECSXEnth3siUWoXnefmlImheNRTHDXBpGH5oP975PMboF
         EU2F62drgT3qL2KvjvMJNJ5aisTCHJdyfA3Yi3cKkYJYd44jw/T8FX8sSaUHDMLR1r7E
         P1MTTGzfq27HFqxMLwY58subfzSrBx8/I3IM/oqALXHvfaUY6WseAfowyyHgJyg+dlzg
         yvgUigRWHkt4RLdUYjc1T+/T4A2InPEX6CxMTZy/01pISW1EafoyBCFVxEEn9xc3YrTC
         M/UgiKLBcOgaL9MtiIswA7AfNxfBp1TPKVUvn7NGUKxn3QWpxAkiQoD5hLGrYmZmoZmj
         5Hag==
X-Gm-Message-State: APjAAAVvyApA/PGULSbTgLXbxJ2Dv2gCkfZVl+DbQ87gtYO418F3MlT/
        95+agxmgW/LeyZfBstoJf6+kfHMSS9Zj0KecPLU=
X-Google-Smtp-Source: APXvYqzUyI1DkiewOUq76ctqoWRhaFKDY2EeiUmPqH+S1LBGO00cWRKX+8Zt21jIMmFPghy6M8JEz1p4PBsy0ZRBi8g=
X-Received: by 2002:a02:a481:: with SMTP id d1mr2247658jam.81.1579592133440;
 Mon, 20 Jan 2020 23:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20160210191715.GB6339@birch.djwong.org> <20160210191848.GC6346@birch.djwong.org>
 <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com> <0089aff3-c4d3-214e-30d7-012abf70623a@gmx.com>
In-Reply-To: <0089aff3-c4d3-214e-30d7-012abf70623a@gmx.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jan 2020 09:35:22 +0200
Message-ID: <CAOQ4uxjd-YWe5uHqfSW9iSdw-hQyFCwo84cK8ebJVJSY_vda3Q@mail.gmail.com>
Subject: Re: [Lsf-pc] [LFS/MM TOPIC] fs reflink issues, fs online scrub/check, etc
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Steve French <smfrench@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org, xfs <xfs@oss.sgi.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 3:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> Didn't see the original mail, so reply here.

Heh! Original email was from 2016, but most of Darrick's wish list is
still relevant in 2020 :)

I for one would be very interested in getting an update on the
progress of pagecache
page sharing if there is anyone working on it.

Thanks,
Amir.
