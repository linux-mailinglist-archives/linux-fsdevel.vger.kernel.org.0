Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F4139C4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgAMWR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:17:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44399 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:17:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so10523523otj.11;
        Mon, 13 Jan 2020 14:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bK5tAWYYK9RXUwEYak4dnGM+/7DX2wX/UYXB9gMajUQ=;
        b=ST4aSNTTlA/yd/eg+W3JhTUhV6Lymv/8pDR/NCMtzSaGxbjejrjsj5JOOrNLmLFwHS
         txzGWLc7LtTQZA6H/Pv6XNc+Yj9EOcL7cvnwGRpc6XJxvOiJq3cx58d8ft+HUt6C2EeE
         5tkBZAWLGSOKcNV0tpGqAUSpp+x2yS4V9yBaYhcrOTz9bKAZ+8q4Sqn1s04dV2WS3OcY
         kM9V7JcMhFPU1A8RkJoC/BLny1iM3OC/qfL5CTrVhKenXWKqOBdNcV7c6G0z60fcLmjE
         +qx1uMIRkYyJB+1xarfE3iHNDSMlNrslZFTlNx5LphRGI5Ta+JQx/9q6TLTHtePJ5k7M
         gnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bK5tAWYYK9RXUwEYak4dnGM+/7DX2wX/UYXB9gMajUQ=;
        b=hFgAEMWCyUWT6hLAcaz3qWAmvcMxtEjspfQe5tVGvJ9dACd+6oFEftXyR/4yfuhDRK
         9dwvkZZKJRl321V+2NwHkKe7KCu/1G1yG5zjyVB8XbuPo2oSVS6XQFsQNPsWu5rfBHeD
         wFkEHOrthJ2Aku29i6jGQHY5UCzj44dHZknMcaKpsPNuFIXnPhZ2XqEnwdcv4R/6HQTA
         wqRU/aLKMdu7UXUNHueXgLEwirwKEIeTxJfFi95mFn1GBjJhJbn2GXaRYmdSdWaR3NS+
         ZJRQ5eHN2rhzHlgmClHbGllpVqTgOfIkuWbRcoJti8wkIsBMO/Et9od/uUT2fAZEWilb
         Ilew==
X-Gm-Message-State: APjAAAU1TnQp4bl3ylQ3ByAX+4ZP9IaMjiqh0Q0YyCBJSUryLdSPcOR0
        c0QZSaU/7PIRJuxR+NXg2sE0ssgkOxpNW4pOU6s=
X-Google-Smtp-Source: APXvYqyVdhG3hldz4ONnrT0gKc2YOBgljzMvL2rp8Bg5pF5JXB45PNzpJxFm6UCbTZB/iCUobze1pw30POKZAru7U64=
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr14851212otp.339.1578953877354;
 Mon, 13 Jan 2020 14:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20191219165250.2875-1-bprotopopov@hotmail.com>
 <CAH2r5mu0Jd=MACMn6_KPvNWoAPVu+V_3FOnoEZxDWoy0x2qEzA@mail.gmail.com>
 <780DD595-1F92-4C34-A323-BB32748E5D07@dilger.ca> <20200113203613.GA111855@jra4>
In-Reply-To: <20200113203613.GA111855@jra4>
From:   Boris Protopopov <boris.v.protopopov@gmail.com>
Date:   Mon, 13 Jan 2020 17:17:46 -0500
Message-ID: <CAHhKpQ6s9szkMk-C8bZzC=3X3APu64Sujc5xtB5-Aa4_beiA7w@mail.gmail.com>
Subject: Re: [PATCH] Add support for setting owner info, dos attributes, and
 create time
To:     Jeremy Allison <jra@samba.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OK, I will look into adding ctime-related attribute, and model it after btime.

On Mon, Jan 13, 2020 at 3:36 PM Jeremy Allison <jra@samba.org> wrote:
>
> On Mon, Jan 13, 2020 at 01:26:39PM -0700, Andreas Dilger via samba-technical wrote:
> > On Jan 9, 2020, at 12:10 PM, Steve French <smfrench@gmail.com> wrote:
> > >
> > > One loosely related question ...
> > >
> > > Your patch adds the ability to set creation time (birth time) which
> > > can be useful for backup/restore cases, but doesn't address the other
> > > hole in Linux (the inability to restore a files ctime).
> > >
> > > In Linux the ability to set timestamps seems quite limited (utimes
> > > only allows setting mtime and atime).
> >
> > The whole point of not being able to change ctime and btime as a regular
> > user is so that it is possible to determine when a file was actually
> > created on the filesystem and last modified.  That is often useful for
> > debugging or forensics reasons.
> >
> > I think if this is something that SMB/CIFS wants to do, it should save
> > these attributes into an xattr of its own (e.g. user.dos or whatever),
> > rather than using the ctime and btime(crtime) fields in the filesystem.
>
> FYI, we (Samba) already do this for create time to store/fetch it
> on systems and filesystems that don't store a create time. It's
> easy to add extra info here.
