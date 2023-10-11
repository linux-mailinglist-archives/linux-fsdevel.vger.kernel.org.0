Return-Path: <linux-fsdevel+bounces-50-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A237C510F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC89282212
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D91DDC7;
	Wed, 11 Oct 2023 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODAiov4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5961097D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:07:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB731FE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697022405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5ykf39aqWNOUh8hPUCI/eBpTU0D+3eGNJ/G++fJXuk=;
	b=ODAiov4Ojb+loQTLw2jxvKnt8K6dXPVj9LL2Ls2Abl1vzLd8+gFpBdV5PvvvHVoOj0S35q
	zyRKG1Rhpx1nGNuKdaCzUXs07ujphWLezS0dH/Z800ogadw8INteF+QlZUWA7oxooVuyMe
	LZ45OX0I1/egVh1buTW/xvaYcrag7ko=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-9Z7TJsXwM_iJoZjJQ7KVZA-1; Wed, 11 Oct 2023 07:06:42 -0400
X-MC-Unique: 9Z7TJsXwM_iJoZjJQ7KVZA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-537efd62f36so5388597a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697022401; x=1697627201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5ykf39aqWNOUh8hPUCI/eBpTU0D+3eGNJ/G++fJXuk=;
        b=qiPU9gvb6spjOY4Tlwjkvv8eVcoa4sOfKmGyf74VFadho9bVOGL3pinJY6N86Lt87O
         1pTuyB0YDb+VRdpxp2caPpLyjNKh+0xcR4nVWanVMJp3OxsmuJMQ1S18CMO4Me/gmBwg
         dwa5pDfX1dAG610ijgg6lQ8mfm+HvulAaaKWLEnSzLFLzTSQEnW7gHRe4Lz1wFJlXs46
         ME3IfiaMjaKbLuUe0K6dayopdv1frePAQ/281Q+Vh/ctRhsOkS0512Wds2sp7S2Ltpyp
         UOxfSyWuloMOC+HdGTeT+QaENxWxtyAq/apNU6IvzkDMmvbe1aNcDN5rxfl1M+CMyfr8
         UJ+Q==
X-Gm-Message-State: AOJu0Yx6awMwS6qr1blh+v5sjqDHxZkhI21XICC4ucc8kFZGozGSFpuu
	i5dmSdEDefaKt0lazyv4ujNTlGCWXbV1YhXBgjenyLKLNg/oICJRcfUztrIrWGQ98kGmTZIIsX2
	PXznChCv2qpi7xTfjUMXbianZ
X-Received: by 2002:a50:ee0a:0:b0:530:4967:df1a with SMTP id g10-20020a50ee0a000000b005304967df1amr16923182eds.17.1697022401084;
        Wed, 11 Oct 2023 04:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSGYnkltW7whS6Jj12+S7pY5s2T9PH4UQibdHpglYLF1SUbXTX1V2fcfwWWQglY7dJbEAyjA==
X-Received: by 2002:a50:ee0a:0:b0:530:4967:df1a with SMTP id g10-20020a50ee0a000000b005304967df1amr16923158eds.17.1697022400685;
        Wed, 11 Oct 2023 04:06:40 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7c44e000000b005361fadef32sm8628821edr.23.2023.10.11.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:06:40 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:06:39 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 05/28] fs: add FS_XFLAG_VERITY for fs-verity sealed
 inodes
Message-ID: <bwwok7q2mf6loildyudbuwazvojz5e4aiqhnn4ptgmno4w2wym@xrvlvhk3u2hy>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-6-aalbersh@redhat.com>
 <20231011040544.GF1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011040544.GF1185@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 21:05:44, Eric Biggers wrote:
> There's currently nowhere in the documentation or code that uses the phrase
> "fs-verity sealed file".  It's instead called a verity file, or a file that has
> fs-verity enabled.  I suggest we try to avoid inconsistent terminology.
> 
> Also, it should be mentioned which kernel versions this works on.
> 
> See for example what the statx section of the documentation says just above the
> new section that you're adding:
> 
>     Since Linux v5.5, the statx() system call sets STATX_ATTR_VERITY if
>     the file has fs-verity enabled.

Sure, will change terminology. Would it be fine to add kernel
version in additional patch when patchset is merged?

> 
> Also, is FS_XFLAG_VERITY going to work on all filesystems?  The existing ways to
> query the verity flag work on all filesystems.  Hopefully any new API will too.
> 

Yes, if FS_VERITY_FL is set on the verity file. I will probably move
hunks in fs/ioctl.c from [1] to this patch so it makes more sense.

> Also, "Extended file attributes" is easily confused with, well, extended file
> attributes (xattrs).  It should be made clear that this is talking about the
> FS_IOC_FSGETXATTR ioctl, not real xattrs.
> 
> Also, it should be made clear that FS_XFLAG_VERITY cannot be set using
> FS_IOC_FSSETXATTR.  See e.g. how the existing documentation says that
> FS_IOC_GETFLAGS can get FS_VERITY_FL but FS_IOC_SETFLAGS cannot set it.

Thanks, will add it.

[1]: https://lore.kernel.org/all/20231011013940.GJ21298@frogsfrogsfrogs/T/#m75e77f585b9b7437556d108c325126865c1f6ce7

-- 
- Andrey


