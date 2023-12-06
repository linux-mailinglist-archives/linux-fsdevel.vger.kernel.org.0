Return-Path: <linux-fsdevel+bounces-5042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F083F8077DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D93B20E34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E3364
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT9oPO1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05A6D42;
	Wed,  6 Dec 2023 10:30:37 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b9cc78d328so87509b6e.3;
        Wed, 06 Dec 2023 10:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701887437; x=1702492237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJAZ/jJ1lCkqUr4OFytX5WnFEtupCNITkqPY5o5pyG0=;
        b=RT9oPO1FJCH+twJh/n71KMOARqW9bzIseu2Fo+8MuziE7NQvlh1IFoQS0qJViceCJ/
         9agcIOPJ53+tKKxECniGp3/buMIu/fbxTI2UE0vHWRywlGcdbPViXkzOMi6nk9WY7J9c
         rWVrjT64ZmXMpAlfsSyBY76zTmNtiptdlYbZVsMFza4uVziaxWCe+brEd3CKf/r5nxcc
         Zif02gGAJwLJZbPjyE/tbsyAmcFg5hpfSD4y6ChZ0pwwqr+lrFRD9f2SqHyppypcpKBk
         CPCjculWr6VZBaS+q0nFwJ7aIXSrW/KRFS+/Rc3Q6sjka799TUn/Vh8HDAxaWPL8ONaE
         iWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887437; x=1702492237;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJAZ/jJ1lCkqUr4OFytX5WnFEtupCNITkqPY5o5pyG0=;
        b=GWD6RfG/fKn+QdD75s3SyKDmuw7TzYvazqVfcfUYxz+uWEYfinWhWKyrOzs37FvHZK
         sOcpjgJQKLKmzH/3e8UKT6nqBD5gWDtOmKIZgvkt0nmwouIx9EsphUwmRZEhMNQVAd4K
         oYzbjFm5757XN+hEdeIJMgmz3ScZtCKqxRMfmkCq3xrBYkZMuOOCqHTLdb5zlnAuWeO+
         PErNbBMt4FAEy0Ow10sgqPNrFzGcgcQn/HjLEImybAtO3P+/LEIOAYd91dG00w1Ft9e1
         grAlI8bVuuXAvk0uyzZN4qlZMSobmdZM9ES8Ht752aVpc/V1H27WElxFz3nuAAaGkBkJ
         MKHw==
X-Gm-Message-State: AOJu0Ywn0rfYhSJpHAx+4Fsh71a3MJVhJkjvPBFpBdEeQIgmCcsDaikp
	ni7ip398UakOtwmR7FDWVhhvL7/awzryJG1MvtXOg7B5FuAzkw==
X-Google-Smtp-Source: AGHT+IEiTk8lgkH5BrOGSqsNNN3Xksa3/U+y0Fblv8doHn91vsqMwB/Vl2Pn3CTtrOBwyL6MSlrLyzT6K8JFQcv5FeA=
X-Received: by 2002:a05:6870:1b83:b0:1fb:4a6:31dd with SMTP id
 hm3-20020a0568701b8300b001fb04a631ddmr1541051oab.42.1701887436874; Wed, 06
 Dec 2023 10:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6802:30f:b0:50c:13ee:b03d with HTTP; Wed, 6 Dec 2023
 10:30:36 -0800 (PST)
In-Reply-To: <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
References: <20231201065602.GP38156@ZenIV> <20231201200446.GA1431056@ZenIV>
 <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020> <20231204195321.GA1674809@ZenIV>
 <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020> <20231206054946.GM1674809@ZenIV>
 <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020> <20231206161509.GN1674809@ZenIV>
 <20231206163010.445vjwmfwwvv65su@f> <CAGudoHF-eXYYYStBWEGzgP8RGXG2+ER4ogdtndkgLWSaboQQwA@mail.gmail.com>
 <20231206170958.GP1674809@ZenIV> <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 6 Dec 2023 19:30:36 +0100
Message-ID: <CAGudoHGgqH=2mb52T4ZMx9bWtyMm7hV9wPvh+7JbtBq0x4ymYA@mail.gmail.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-doc@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Can I get instructions how to reproduce the unixbench regression?

I only found them for stressng.

-- 
Mateusz Guzik <mjguzik gmail.com>

