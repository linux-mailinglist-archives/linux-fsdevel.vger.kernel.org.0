Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADBD132246
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 10:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgAGJ3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 04:29:24 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50632 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGJ3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:29:24 -0500
Received: by mail-wm1-f48.google.com with SMTP id a5so18143735wmb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0RtvehmZAY2xm5teOPM9N5+pwz+MVcm7hB4hWA014U=;
        b=bDLO9ps8qlJsulNfvf4m8YPD4Cjd+6SHyV4A3OcFB3LVrqHhRhaGxi8Q6HgLBlQ04J
         lyPn/20bUuiw1NKdXW7kA418zRlVpa4MyNIlTkGuGUhlLMgRM5910ZC0TFpMFgEgVdtY
         aAW2JNKpvwqAIntR/GzK4ZQUhp0oQ3Te+UKoU9UOZCoudyv8K9x6wU2VwVDOPExVVC62
         chaMfRxuIZno/2/7/I6MyvqLOLSL9rVEJd7P+snDIuCWEJjz+rBzfVB/Ylp0+oBk4DX7
         +u09UAAJCoUE78nVNmL3qFxwwveyLE8XyCBtRldlOuXHB8z7IQag+rJjFvum15zI4K9g
         VsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0RtvehmZAY2xm5teOPM9N5+pwz+MVcm7hB4hWA014U=;
        b=tID7QDeDvAQ0C8Xdk5sZHz5PI58fqyU+SYVUBCIeP/7e9Wrv6k8XlfKO4vAb8tBY5i
         B2MVPl5ilubfcRkDLC740WIUfloqasP6UJ1pijYil6vBfKFFm/91Y3n4YqkVGZ2Frw8l
         YtqffuO/aNWekm7+mbqIYKAeAt+60j4hf7/nSCY1XGvg61yDF2fwxl5UQ1uowIzxdQdL
         iQXldJ8artz//6yIrZM3vIlD9t787Afisp/JDYLxeaGrwKszrg+0R9jCbkzPjEPVUOgi
         AnGz3pRolkksqiiAd66dqUbPVv6/ulSpCCZmsutNzSnWcfgAM3CF7FQR4DHVILhOFcSH
         XKiA==
X-Gm-Message-State: APjAAAWU9GbLcsasj5vp1/lV6Z03nm9tqSRBGNZGDgOxliJu9enN6d9B
        a8m49GRL8uaT0q2vQXlhCBQnyJdONl8Wq0GhTtI=
X-Google-Smtp-Source: APXvYqz79cMDweyaQhtNx4dfnm37WnlDWHobeFYc/4OLSiriyIRcqnzZNyjX0Uop2EWKQA+0Fo12021uYnAHtOoPteg=
X-Received: by 2002:a1c:6585:: with SMTP id z127mr38792633wmb.113.1578389362582;
 Tue, 07 Jan 2020 01:29:22 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com> <20200106164257.GJ6788@bombadil.infradead.org>
In-Reply-To: <20200106164257.GJ6788@bombadil.infradead.org>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Tue, 7 Jan 2020 09:28:56 +0000
Message-ID: <CALjAwxhnPtW0DvNvOpON6gHwQSXn-9HVT5z4XmGuOneBxRbr5A@mail.gmail.com>
Subject: Re: Questions about filesystems from SQLite author presentation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, drh@sqlite.org,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Jan 2020 at 16:42, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 06, 2020 at 05:40:20PM +0200, Amir Goldstein wrote:
> > On Mon, Jan 6, 2020 at 9:26 AM Sitsofe Wheeler <sitsofe@gmail.com> wrote:
> > > If a write occurs on one or two bytes of a file at about the same time as a power
> > > loss, are other bytes of the file guaranteed to be unchanged after reboot?
> > > Or might some other bytes within the same sector have been modified as well?
> >
> > I don't see how other bytes could change in this scenario, but I don't
> > know if the
> > hardware provides this guarantee. Maybe someone else knows the answer.
>
> The question is nonsense because there is no way to write less than one
> sector to a hardware device, by definition.  So, treating this question
> as being a read-modify-write of a single sector (assuming the "two bytes"
> don't cross a sector boundary):
>
> Hardware vendors are reluctant to provide this guarantee, but it's
> essential to constructing a reliable storage system.  We wrote the NVMe
> spec in such a way that vendors must provide single-sector-atomicity
> guarantees, and I hope they haven't managed to wiggle some nonsense
> into the spec that allows them to not make that guarantee.  The below
> is a quote from the 1.4 spec.  For those not versed in NVMe spec-ese,
> "0's based value" means that putting a zero in this field means the
> value of AWUPF is 1.

Wow - that's the first time I've seen someone go on the record as
saying a sector write is atomic (albeit only for NVMe disks) without
having it instantly debated! Sadly there's no way of guaranteeing this
atomicity from userspace if https://youtu.be/-oP2BOsMpdo?t=3557 (where
Chris Mason(?) warns there can be corner cases trying to use O_DIRECT)
is to be believed though?

> I take neither blame nor credit for what other storage standards may
> implement; this is the only one I had a hand in, and I had to fight
> hard to get it.

So there's no consensus for SATA/SCSI etc
(https://stackoverflow.com/questions/2009063/are-disk-sector-writes-atomic
)? Just need to wait until there's NVMe everywhere :-)

-- 
Sitsofe | http://sucs.org/~sits/
