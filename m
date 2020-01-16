Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E113D7CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 11:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgAPKTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 05:19:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37678 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPKTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:19:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so18567400wru.4;
        Thu, 16 Jan 2020 02:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8YLvB3XoNFBQYdtBQKX47B+CGWk8SGLdVn5B91WfpIo=;
        b=jBhAcdhO41+t8pAlJ5bITHVITLqRCLcSpa4nKNE4I/MuP/cv2nVUtsYj5OSCCMXDil
         sbBooGPX8QKnJX04ji0TP1gpvEbbnNvPjS+/yn6JvZZqkWHr09wZAt8JB5wdA2Vd/b/N
         S+HIglPE37lwYJs8XR55sSZ9GPCu7zaoNbY1V6t38QPiS3kXzIDVWaDR1DQnuTMXU5Dj
         YJqPLcIno4bsLy6PlbyhnH9d0y4C3AUJXbjUi/CesBwvjO/m3yF9ahBXYxKB3H0m/sRO
         iGiZbFinx+1v6CWB7W+9fXP2UmRGgpVm3AdNFRE0Ozz/5QA8j7sbVEVsfp+ID6UsLODe
         FeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8YLvB3XoNFBQYdtBQKX47B+CGWk8SGLdVn5B91WfpIo=;
        b=LyA7+o37eVF5c5iwTi1v0FyOotwyNV6zEnRgSc2Mv1jTrPKVpHv2DeVsloSqsE2mbG
         a4EvLazSceF+DmefrXm7RNmMuPSgrAunRhjFzsKDfUE8VHuyr8z9UPfrKzl5/EEghmzU
         qkbVM2r0sqcZPckA52CP/Sds2u1HaxetVXwcu+b5jI2+vvQnDgaF2abwzqy/5LRJ8dl7
         ejpUm1i8bT6D7AMemjE48Bl9YHy+rL+ngd+BuO5KnsWLSsMOaDksl5t4468Xo46kGP2R
         Qvb2e8Y5SFBNQW2jCZ6Sf3TnEy3XojkUhu2+sX3feLWmhOJbxpcK4A9I0xs4o2LXvxxo
         SGSA==
X-Gm-Message-State: APjAAAXCX/LJiilNLsqyjQ3MdrkWwhjvG9WzOPhBmGTulAX3UHWIvVLQ
        GzU4r12hL4zSh4GnVSMhKC/t8gy/
X-Google-Smtp-Source: APXvYqymEY+PHjbSJtOO1mw1VsKm1mb8uVLxE/besyg36E1OJ1xp7TEMnNWdcwRNtTyv711C9e0gGA==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr2475282wrp.322.1579169990172;
        Thu, 16 Jan 2020 02:19:50 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p7sm2260591wmp.31.2020.01.16.02.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 02:19:49 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:19:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
Message-ID: <20200116101947.4szdyfwpyasv5vpe@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali>
 <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
 <20200115142428.ugsp3binf2vuiarq@pali>
 <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
 <20200115153943.qw35ya37ws6ftlnt@pali>
 <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 16:52:12 Arnd Bergmann wrote:
> On Wed, Jan 15, 2020 at 4:39 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Wednesday 15 January 2020 16:03:12 Arnd Bergmann wrote:
> > > The vdso and kernel/time/ code are for maintaining the timezone through
> > > settimeofday()/gettimeofday(), and the drivers should probably all be changed
> > > to use UTC. The file systems (affs, fat, hfs, hpfs and udf) do this for
> > > compatibility with other operating systems that store the metadata in
> > > localtime.
> >
> > Ok. But situation for exFAT is quite different. exFAT timestamp
> > structure contains also timezone information. Other filesystems do not
> > store timezone into their metadata (IIRC udf is exception and also
> > stores timezone). So question is in which timezone we should store to
> > exFAT timestamps. This is not for compatibility with legacy systems, but
> > because of fact that filesystem supports feature which is not common for
> > other filesystems.
> >
> > Also, to make it more complicated exFAT supports storing timestamps also
> > in "unspecified" (local user) timezone, which matches other linux
> > filesystems.
> >
> > So for storing timestamp we have options:
> >
> > * Store them without timezone
> > * Store them in sys_tz timezone
> > * Store them in timezone specified in mount option
> > * Store them in UTC timezone
> >
> > And when reading timestamp from exFAT we need to handle both:
> >
> > * Timestamps without timezone
> > * Timestamps with timezone
> 
> Right.
> 
> > So what is the best way to handle timezone/timestamps?
> >
> > For me it looks sane:
> >
> > When storing use: mount option timezone. When not available then use
> > sys_tz. And when sys_tz is not set (it is possible?), do not specify
> > timezone at all. Maybe there should be a mount option which says that
> > timestamps on exfat are stored without timezone.
> 
> I would argue we should always store files in UTC, which seems to be
> the most consistent with other file systems, and can be understood
> by any other implementation that understands the timezone information
> on disk  or that expects UTC.

exFAT timezone information needs to be understand by any exFAT
implementation.

I looked into exFAT specification and it has following information how
implementation should choose timezone:

https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#74101-offsetfromutc-field

  However, implementations should only record the value 00h for this
  field when:

    1. Local date and time are actually the same as UTC, in which case
       the value of the OffsetValid field shall be 1

    2. Local date and time are not known, in which case the value of the
       OffsetValid field shall be 1 and implementations shall consider
       UTC to be local date and time

    3. UTC is not known, in which case the value of the OffsetValid
       field shall be 0

I'm not sure if storing time always in UTC is fine with specification.

Mount option which specify timezone can solve this problem, but only in
case when it is specified.

> > When reading timestamp with timezone: Convert timestamp to timezone
> > specified in mount option (or fallback to sys_tz or fallback to UTC).
> 
> Here I would just convert to UTC, which is what we store in the
> in-memory struct inode anyway.

Ok. If inode timestamp is always in UTC, we should do same thing also
for exFAT.

> > And when reading timestamp without timezone: Pass it as is without
> > conversion, ignoring all timezone mount options and sys_tz.
> >
> > Arnd, what do you think about it?
> 
> The last case (reading timestamp without timezone) is the only
> one that I think we have to decide on: when reading an inode from
> disk into memory, we have to convert it into UTC in some form.
> 
> This is what I think the timezone mount option should be used
> for: if we don't know what the timezone was for the on-disk
> timestamp, use the one provided by the user.

I agree, this make sense.

> However, if none
> was specified, it should be either sys_tz or UTC (i.e. no
> conversion). I would prefer the use of UTC here given the
> problems with sys_tz, but sys_tz would be more consistent
> with how fs/fat works.

Hm... both UTC and sys_tz have positives and negatives. And I'm not
sure which option is better.

Do we know how Tuxera or Paragon solved this dilema in their exFAT
implementations? IIRC Paragon already sent their implementation to LKML.

-- 
Pali Rohár
pali.rohar@gmail.com
