Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70E13DF19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 16:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgAPPqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 10:46:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45248 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgAPPqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:46:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so19607470wrj.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 07:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s0NRa2rT4BffC1t6eHvPRzuD07TBcNtovxA13ffezR4=;
        b=f84GkhRfksprfzqSUu5i9biEpvz2CBSO5IHPNT9qlzY+iLl5lLsEJ+TzweCUGBs/he
         pRwkLkhOXRYAFKoxkf2WIzBxPxqfK14LJVZaqZ+e/1uaN52EmDI0cmOBvrBrsrBGz0Dg
         dBqjFYjuAqqETtP67OdkusOfNa1VQ1MgIFdFOb9bKbABF9SEcwLrcCbub2lOETqAJYFm
         ly2i/keYxwA+i/cjZzzFfwxytivJhW91w/TS9drAZPo20GfhY8ilMDTVke/dlLxqh93+
         VFcDotVfdcCmwIJ1wLceWSkC0bEMGckMXUl2MvktC8m7ZiOv9LV5oplrRkmzOgsjXQCL
         5Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s0NRa2rT4BffC1t6eHvPRzuD07TBcNtovxA13ffezR4=;
        b=QlaNQ/qeG3jo/y7EdsT/pn1uUk5jYNzNOPnGfePR4ohbL26ZHmHkcckriJ2zmXOC5p
         +QzsZvMWjn/J8oNBV2uDBqgJZXDqX080K0LNcQyP+AWeRMdZYR38nOgj4naWg4BM+sJT
         yA6tK6t4wP7+nD7MgIemHpmP9jC8p/H2mwln2odDdt/ecli5nuWpJeT8khh0L2vE2kBI
         F0zIHeLgt3KadOfsVueK9kdn1dcU2NtgKFSCHAve9XcDQ8e/yHVWU8j1VdyLBDUQNAYb
         v3OTyTRPQoNI3zHrvMfmBrqiK8NvlyY5tEFK5RhaZtcY/TplB57+8RjaNfZCz9Brly7s
         PzSA==
X-Gm-Message-State: APjAAAX0JRkZ+pc65oRVCQseF35QReCXJjmwi01seLC8P8u8nDWhqv7u
        PTXqiyaJr7hg2LTDAfLm4QfnuDH9
X-Google-Smtp-Source: APXvYqwL+quORjQNiy9UUvPooG6LbPcEiW81mCMzpIECdvoO9tbfEVePPyi9iExA1LVVyU7YcpZcaw==
X-Received: by 2002:adf:f052:: with SMTP id t18mr3922656wro.192.1579189604920;
        Thu, 16 Jan 2020 07:46:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t125sm5400958wmf.17.2020.01.16.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:46:44 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:46:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>
Subject: Re: udf: Commit b085fbe2ef7fa (udf: Fix crash during mount) broke
 CD-RW support
Message-ID: <20200116154643.wtxtki7bbn5fnmfc@pali>
References: <20200112144735.hj2emsoy4uwsouxz@pali>
 <20200113114838.GD23642@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113114838.GD23642@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 13 January 2020 12:48:38 Jan Kara wrote:
> Hello,
> 
> On Sun 12-01-20 15:47:35, Pali Rohár wrote:
> > Commit b085fbe2ef7fa (udf: Fix crash during mount) introduced check that
> > UDF disk with PD_ACCESS_TYPE_REWRITABLE access type would not be able to
> > mount in R/W mode. This commit was added in Linux 4.20.
> > 
> > But most tools which generate UDF filesystem for CD-RW set access type
> > to rewritable, so above change basically disallow usage of CD-RW discs
> > formatted to UDF in R/W mode.
> > 
> > Linux's cdrwtool and mkudffs (in all released versions), Windows Nero 6,
> > NetBSD's newfs_udf -- all these tools uses rewritable access type for
> > CD-RW media.
> > 
> > In UDF 1.50, 2.00 and 2.01 specification there is no information which
> > UDF access type should be used for CD-RW medias.
> > 
> > In UDF 2.60, section 2.2.14.2 is written:
> > 
> >     A partition with Access Type 3 (rewritable) shall define a Freed
> >     Space Bitmap or a Freed Space Table, see 2.3.3. All other partitions
> >     shall not define a Freed Space Bitmap or a Freed Space Table.
> > 
> >     Rewritable partitions are used on media that require some form of
> >     preprocessing before re-writing data (for example legacy MO). Such
> >     partitions shall use Access Type 3.
> > 
> >     Overwritable partitions are used on media that do not require
> >     preprocessing before overwriting data (for example: CD-RW, DVD-RW,
> >     DVD+RW, DVD-RAM, BD-RE, HD DVD-Rewritable). Such partitions shall
> >     use Access Type 4.
> > 
> > And in 6.14.1 (Properties of CD-MRW and DVD+MRW media and drives) is:
> > 
> >     The Media Type is Overwritable (partition Access Type 4,
> >     overwritable)
> > 
> > Similar info is in UDF 2.50.
> 
> Thanks for detailed info. Yes, UDF 2.60 spec is why I've added the check
> you mentioned. I was not aware that the phrasing was not there in earlier
> versions and frankly even the UDF 2.60 spec is already 15 years old... But
> the fact that there are tools creating non-compliant disks certainly
> changes the picture :)

I tested also Nero Linux 4 (Nero provides free trial version which is
fully working even in 2020) and it creates 1.50 CD-RW discs in the same
way with Rewritable partition. Interestingly for 2.50 and 2.60 it does
not use Overwritable, but Writeonce (yes, for CD-RW with Spartable).

And because previous UDF specification do not say anything about it, I
would not sat that those discs are non-compliant.

Moreover, is there any tool (for Linux or other system) which uses
Overwritable partition type for CD-RW discs? All which I tested uses
Rewritable.

> > So I think that UDF 2.60 is clear that for CD-RW medias (formatted in
> > normal or MRW mode) should be used Overwritable access type. But all
> > mentioned tools were probably written prior to existence of UDF 2.60
> > specifications, probably targeting only UDF 1.50 versions at that time.
> > 
> > I checked that they use Unallocated Space Bitmap (and not Freed Space
> > Bitmap), so writing to these filesystems should not be a problem.
> > 
> > How to handle this situation? UDF 2.01 nor 1.50 does not say anything
> > for access type on CD-RW and there are already tools which generates UDF
> > 1.50 images which does not matches UDF 2.60 requirements.
> > 
> > I think that the best would be to relax restrictions added in commit
> > b085fbe2ef7fa to allow mounting mounting udf fs with rewritable access
> > type in R/W mode if Freed Space Bitmap/Table is not used.
> > 
> > I'm really not sure if existing udf implementations take CD-RW media
> > with overwritable media type. E.g. prehistoric wrudf tool refuse to work
> > with optical discs which have overwritable access type. I supports only
> > UDF 1.50.
> 
> Yeah, we should maintain compatibility with older tools where sanely
> possible. So I agree with what you propose. Allow writing to
> PD_ACCESS_TYPE_REWRITABLE disks if they don't use 'Freed Space
> Bitmap/Table'. Will you send a patch or should I do the update?

Could you do it, please?

Also question is, what with those 2.50 CD-RW Writonce partitions and
with Spartable which creates Nero Linux?

-- 
Pali Rohár
pali.rohar@gmail.com
