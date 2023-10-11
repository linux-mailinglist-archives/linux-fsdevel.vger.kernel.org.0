Return-Path: <linux-fsdevel+bounces-70-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E77C5701
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C5D282661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616DE1427C;
	Wed, 11 Oct 2023 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTdgOqVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFA208A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 14:37:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D42E92
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697035026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34baUARs91EkkCBFmzlWLNU8Iitqc+tKVHHJesgsXbs=;
	b=VTdgOqVKy2Xx7lxMktrxWkJ+GXYqmSqBX3ROIPzPmZ3tSlbwxWrTR0+VvCjdroZ/a9FpY7
	qOloTNnvfdRjM8A6CwyYGK8mXR6gGF5fnWjKfQNwVcVa6ztXBmrT2BMudPttVeoB6k5g79
	XdHoql9hePFsV9LNuYuBoB51cbjRFRg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-agAfozY9Nf2VbPShsgZGpA-1; Wed, 11 Oct 2023 10:37:04 -0400
X-MC-Unique: agAfozY9Nf2VbPShsgZGpA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99c8bbc902eso555764066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035023; x=1697639823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34baUARs91EkkCBFmzlWLNU8Iitqc+tKVHHJesgsXbs=;
        b=cTr1l+zfVQJ8Z9Wl+/zb53tisvMYen00oin1VMM69uzYA9tCIqoeTVRx3ggHZEk+7m
         6I6tU1WUdU2yGq0VEWUc/CDsyqy2zkSGfe2e1BcsNQccwzkhIBdoHtKQMbX+ZfJJAVEp
         MZmPAa83vYVR5kucqzQxixYRom8s4a59XVHyTTODzXlrPdEUuxa8ZuZ6EJHc3TzxZeak
         RuxNNs687TFjcjUM52s/waMBFc23ba0aPKCloh6QSS/UlqjZSZH6NvsaDbHQYejP2mRp
         WkmIl6ol5/D2imrBjBq4V3MIiBvn5xSBj3DM6cKW2gtaN2bx26ZjHDuohIjiK56/NwRT
         8XSw==
X-Gm-Message-State: AOJu0YzaxGhDQZu05y9ZbrWwzqkzLUXDt1gZspYqMx4mhbb0YPWthG21
	ieuqYrYT2hkVKNA8R9dOXznETresoJOfCoEq4IZC7iuJEc6K1a4YF1yivtT2EQSoUs2V3/oHaSx
	dt31q7OYjisE8aHJXW5DJe3BR
X-Received: by 2002:a17:906:4c9:b0:9a6:572f:597f with SMTP id g9-20020a17090604c900b009a6572f597fmr17398650eja.38.1697035023442;
        Wed, 11 Oct 2023 07:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPo2YB484LHLqni0xArxuSgEFDfsRNtQl070YQebW8HyUaykksPcIpxZzOOF+gbR7567Puiw==
X-Received: by 2002:a17:906:4c9:b0:9a6:572f:597f with SMTP id g9-20020a17090604c900b009a6572f597fmr17398636eja.38.1697035023119;
        Wed, 11 Oct 2023 07:37:03 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id dx8-20020a170906a84800b0099cbfee34e3sm9819150ejb.196.2023.10.11.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:37:02 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:37:02 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 26/28] xfs: make scrub aware of verity dinode flag
Message-ID: <6o4zaqtxsyetq2cfaxuxfpkxf55tazafoen7plhjywetei6h6q@xnzapk24io6e>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-27-aalbersh@redhat.com>
 <20231011010641.GI21298@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011010641.GI21298@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 18:06:41, Darrick J. Wong wrote:
> On Fri, Oct 06, 2023 at 08:49:20PM +0200, Andrey Albershteyn wrote:
> > fs-verity adds new inode flag which causes scrub to fail as it is
> > not yet known.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks!

-- 
- Andrey


