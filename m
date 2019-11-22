Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368E2107BC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 00:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKVX7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 18:59:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42835 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVX7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:59:30 -0500
Received: by mail-io1-f67.google.com with SMTP id k13so10087239ioa.9;
        Fri, 22 Nov 2019 15:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foB4NLZVZpZHpEP+Jauf8VZD20bjVJasgM3S94B+BBs=;
        b=X6nMM/vlSIJvr2rQybFVo45ZCgO5wPCt1i501De4QJ38e+Qw9Wfcn6S964E76rZ5KF
         frkvASOl1adlZxqdpgbEMc+spswWqJQVXjEVQ4xYXLoxF8HQfIJBAh8rg8KHC3rqRRMK
         0u/HD+Pg63QEocPelHZu/SjSblAGIG+ag7+BdfFJRIyK1tT+sv0gSFa+FKKkkrcyU0IQ
         wgtONpQEgTGJhNlT7iQoUqIySotOVmas9AjxT+TJziw7x/BLwzLjrAQsCXNFGuvcxIxp
         xlvYTux9FepMtnIPGoJg8WAX/g1ILkZu5CgqIHHeIsyZmnxBw+35uMtVDbLRDFDo1ygs
         MLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foB4NLZVZpZHpEP+Jauf8VZD20bjVJasgM3S94B+BBs=;
        b=ChrdqUXTpCfBix+2oeLBDHh/60ofrsCbG87FaWUXuHJKVtIl/6c2sxc+e2sJFhLDFk
         zjaA6kM8p+TiRcrQvCjYXnZd8T+qDnH/prz5ErSgO0/mh/5pPCVC5AxTx0xC4p8KVEoO
         qVdIKNuDLwsEBsQ5K5fZanLPowzzjgqvSwEnMaYyVWpn09Oox0uJDT/gNypGEXcpK30c
         ZUdgIdU4aP+cpFMUOGPTir2g+p/6cEJcpneK21YHc5V7q4CfJW4chFFDvksmcDawQzGg
         XwHFZAwQXs11VjubSfPAd6bfqyvZLyRzfksYbgKhYnaHHf2uq+dLTewo9Vdbs7eWTOYU
         C4hw==
X-Gm-Message-State: APjAAAWJ5fo2j/Zsvj0e0WA7lkwyBV3tuUNQFhDq4dVH9MEdoDBNYBna
        T8UC+Hlgd0SB5umNxot2uYDDlsYSonDYQZfrk+8=
X-Google-Smtp-Source: APXvYqxEYuoR4iMswSx1CzGapDzROgybF2PYu6v6V5p2Czm4oC+E00ZzOCe0P14r8QIPjTBrJxub730kaFAOaD4G31A=
X-Received: by 2002:a6b:7e0b:: with SMTP id i11mr15044163iom.245.1574467169363;
 Fri, 22 Nov 2019 15:59:29 -0800 (PST)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
 <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com> <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
 <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com>
In-Reply-To: <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Sat, 23 Nov 2019 00:59:18 +0100
Message-ID: <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Am Do., 31. Okt. 2019 um 12:43 Uhr schrieb Steven Whitehouse
<swhiteho@redhat.com>:
> Andreas, Bob, have I missed anything here?

I've looked into this a bit, and it seems that there's a reasonable
way to get rid of the lock taking in ->readpage and ->readpages
without a lot of code duplication. My proposal for that consists of
multiple patches, so I've posted it separately:

https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@redhat.com/T/#t

Thanks,
Andreas
