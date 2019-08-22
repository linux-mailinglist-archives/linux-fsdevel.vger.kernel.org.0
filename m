Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2310898DC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 10:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfHVIdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 04:33:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51196 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfHVIdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:33:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so4742685wml.0;
        Thu, 22 Aug 2019 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EauMan5wC2oHmJwa9VSCeeLzs1qH85S7tn6KqheO0Y=;
        b=OQ7p6IVC1NIw7fex5ur1IYa1YmEGcmleiVeN1rAeX0LVjJz/+s8L+/4nTeG0Tr2Zm7
         KOdjCjmLzgRxyDZjhzwqrfcOYWmX7FWZv8dwg8zAJOdeAQqNRxSiTXIiw7hwH7dofsmW
         CMveJQR7Vtpbpz95ituoxFtAjIhxDa0pF6ZgZvqZuaiPAe4Z75dCgIrcLYaoBDHnN0vF
         r7jwHMqyAir8eYR8R4oYIEpdspGiSRf1vVIYgjpklTqJSbOTmKcQuUOGJxlneCaO5wD3
         hyXv99UXj/cNZ92Fi/DurOZsSnoGXeDaOwQDzubRKWZ6rB0ZDZaABc4b6rWXLOuYikjn
         7Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EauMan5wC2oHmJwa9VSCeeLzs1qH85S7tn6KqheO0Y=;
        b=ip+UcbIt20XKBAPtc6xuI9SVPVFBbUHzVc+oPyAJc3weaz78VJ7HXYJC4L2r+uGFWV
         3MF+Admcon4HKRK8kQNcVwFjhFe5mhpW3WJO8NUlVTe+ngtN60AepJQyCICMPXTBdSIv
         OXnWN/LMWjwoBT7z4yTRB+jRHRt1HgcqgHdl2SZgqEGVJ5FuFdTTKCxxRcd896Rmg14a
         WAjgm3366k87/Csu+Ix7xYh5mF4hZnH2TAU90YDezr7gc2yyXsRcepLS/g14IvoDVYDs
         EJjKNZLSATIY9gv3L8qj0niFle3/b6mLXxingapjB1byWcSoOZgwZCn/sNE2rGEGowHe
         zy6g==
X-Gm-Message-State: APjAAAV10Ut5CLAsGAMpKzauMCpgjU2m3f/jPCEF8dcvpO94AC6mRyZC
        aeRPktJMDSfvfpHgV66Ja5/7ZybYFtEDff9F1HM=
X-Google-Smtp-Source: APXvYqwp3ugo/OV/r/Cwj2DfvvMbvNm+soB016hMmOviIAU2t8QWMrxQSxMeAbb9I1qyMe3BKgqWpfLfM68frYMNOPU=
X-Received: by 2002:a7b:c155:: with SMTP id z21mr4840886wmi.137.1566462793252;
 Thu, 22 Aug 2019 01:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1> <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 22 Aug 2019 10:33:01 +0200
Message-ID: <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
Subject: Re: erofs: Question on unused fields in on-disk structs
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 12:03 AM Gao Xiang <hsiangkao@aol.com> wrote:
>
> Hi Richard,
>
> On Wed, Aug 21, 2019 at 11:37:30PM +0200, Richard Weinberger wrote:
> > Gao Xiang,
> >
> > On Mon, Aug 19, 2019 at 10:45 PM Gao Xiang via Linux-erofs
> > <linux-erofs@lists.ozlabs.org> wrote:
> > > > struct erofs_super_block has "checksum" and "features" fields,
> > > > but they are not used in the source.
> > > > What is the plan for these?
> > >
> > > Yes, both will be used laterly (features is used for compatible
> > > features, we already have some incompatible features in 5.3).
> >
> > Good. :-)
> > I suggest to check the fields being 0 right now.
> > Otherwise you are in danger that they get burned if an mkfs.erofs does not
> > initialize the fields.
>
> Sorry... I cannot get the point...

Sorry for being unclear, let me explain in more detail.

> super block chksum could be a compatible feature right? which means
> new kernel can support it (maybe we can add a warning if such image
> doesn't have a chksum then when mounting) but old kernel doesn't
> care it.

Yes. But you need some why to indicate that the chksum field is now
valid and must be used.

The features field can be used for that, but you don't use it right now.
I recommend to check it for being 0, 0 means then "no features".
If somebody creates in future a erofs with more features this code
can refuse to mount because it does not support these features.

But be very sure that existing erofs filesystems actually have this field
set to 0 or something other which is always the same.
Otherwise you cannot use the field anymore because it could be anything.
A common bug is that the mkfs program keeps such unused fields
uninitialized and then it can be a more or less random value without
notice.

> Or maybe you mean these reserved fields? I have no idea all other
> filesystems check these fields to 0 or not... But I think it should
> be used with some other flag is set rather than directly use, right?

Basically you want a way to know when a field shall be used and when not.
Most filesystems have version/feature fields. Often multiple to denote different
levels of compatibility.

-- 
Thanks,
//richard
