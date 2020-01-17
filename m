Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87952140905
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgAQLfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:35:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34657 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAQLfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:35:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so22386105wrr.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5HzcRMNSryJEbst8HgMoeyJSoKu0O1YOsuf5cQckjLo=;
        b=idgdx27sPDcJV3+pyTPVNiinSsbL1o2RhOxWOYnAiztqbyS5KipQMA1kGbiYYGu0oI
         uilwznCADeW6NfDdQArZXFyDRDB3iVkLt+ukavO5GKJKE5Tfokrb93v4tf8Eksdfye6A
         Edaqc/3ssbVudodeEOAEdaEPjnrncXTQ0yEcyzJNjJMKiXqg4PK2EGpO0XtJEW2N31R0
         HERGhDVyNfOZQr85SSr6oS28CkPQ1QQVKgduC+PUx5UmY5fimXCKAWJup3ovrW1ud1tE
         NZslLrknXEYGGkjWRBPbcHdEz7Fz9mr4yDnw2+1vE9sPYbKleyQNrWJuSzTRjj7xVs/c
         OKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5HzcRMNSryJEbst8HgMoeyJSoKu0O1YOsuf5cQckjLo=;
        b=ov1VBCj23XP6ueYXq0DdD8KT0lZqyMOxh+xSm+ILuYz42OXI2Sz3tuR9ZSZy33j03H
         i1T8iBpv7BQlkZ++eZfBRljA3JYKB9SKrBiNhyr3OnK+1RYznFHHeGtMUXiwgc1vd7PE
         C7LF9BxIXqVClVYs8sbwdgGEVWvBirlGevuNWvziIS5dO7YggOzJ5AfPTK13S+uHNMRA
         inQ0BymYOspMTW4OVpYci2BcYkQ168dVRSuDwijGyZihwr044MSKnE0u0xa2QkDDsEw0
         r7FxxJ/Xp2rz1S2+QJEVKi0jcXnb5NoKUHbjfb3e4eWcrCBNW2ZxGFWd0z/cK1DKUNW/
         Zd/g==
X-Gm-Message-State: APjAAAV1a8uy6Ku3hHe+o93sq0mel/wtYjaVNUBUxgLNk9RweQAyhBNG
        EidHiydatI8m0kQB/khT1/g=
X-Google-Smtp-Source: APXvYqwYcipzNn7R4eoQqc+7IhzwqVOXUkbG3CT3lsS+hFuETsHTm8G1kzTkKksHo2y9hiyD141Hrw==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr2713100wrm.394.1579260939013;
        Fri, 17 Jan 2020 03:35:39 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z83sm34103wmg.2.2020.01.17.03.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:35:38 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:35:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>
Subject: Re: udf: Commit b085fbe2ef7fa (udf: Fix crash during mount) broke
 CD-RW support
Message-ID: <20200117113537.tvyiz3bictp7p2ki@pali>
References: <20200112144735.hj2emsoy4uwsouxz@pali>
 <20200113114838.GD23642@quack2.suse.cz>
 <20200116154643.wtxtki7bbn5fnmfc@pali>
 <20200117112254.GF17141@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117112254.GF17141@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 17 January 2020 12:22:54 Jan Kara wrote:
> On Thu 16-01-20 16:46:43, Pali Rohár wrote:
> > On Monday 13 January 2020 12:48:38 Jan Kara wrote:
> > > On Sun 12-01-20 15:47:35, Pali Rohár wrote:
> > > > So I think that UDF 2.60 is clear that for CD-RW medias (formatted in
> > > > normal or MRW mode) should be used Overwritable access type. But all
> > > > mentioned tools were probably written prior to existence of UDF 2.60
> > > > specifications, probably targeting only UDF 1.50 versions at that time.
> > > > 
> > > > I checked that they use Unallocated Space Bitmap (and not Freed Space
> > > > Bitmap), so writing to these filesystems should not be a problem.
> > > > 
> > > > How to handle this situation? UDF 2.01 nor 1.50 does not say anything
> > > > for access type on CD-RW and there are already tools which generates UDF
> > > > 1.50 images which does not matches UDF 2.60 requirements.
> > > > 
> > > > I think that the best would be to relax restrictions added in commit
> > > > b085fbe2ef7fa to allow mounting mounting udf fs with rewritable access
> > > > type in R/W mode if Freed Space Bitmap/Table is not used.
> > > > 
> > > > I'm really not sure if existing udf implementations take CD-RW media
> > > > with overwritable media type. E.g. prehistoric wrudf tool refuse to work
> > > > with optical discs which have overwritable access type. I supports only
> > > > UDF 1.50.
> > > 
> > > Yeah, we should maintain compatibility with older tools where sanely
> > > possible. So I agree with what you propose. Allow writing to
> > > PD_ACCESS_TYPE_REWRITABLE disks if they don't use 'Freed Space
> > > Bitmap/Table'. Will you send a patch or should I do the update?
> > 
> > Could you do it, please?
> 
> Sure, attached.

Looks good, just you have specified wrong MIME enc: charset=iso-8859-1
It should be UTF-8. You can add my Reviewed-by keyword.

-- 
Pali Rohár
pali.rohar@gmail.com
