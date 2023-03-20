Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F66C1DA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjCTRUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjCTRUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:20:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226F305D0;
        Mon, 20 Mar 2023 10:16:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i5so2712842eda.0;
        Mon, 20 Mar 2023 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2NdZclFgXy4ov5FrjcRf48EixvIBPnhRXDS+1A+mdiw=;
        b=muU8X2kOo5kVUr7GwmuP5/4chenXc2jEl4uuUmaoUYDZ+rMDXMsPjzQXsxgbP904S9
         QNvhMEIB7ia65GCQpeZql+S3H/cso5X/WH7yTs9E4e52nhsFo7eKsEtli0YTvZMBqoyA
         oJsfggIDOBpL9l+HG3Z6Pgnf1q9eh1O2dasPO52VT2Kd8mjz7CuLEZOLemU43qrGmSIy
         dyiw6RUeEZYwszYIAoxMrdz7To32xe1s/roW5ycd8wUE7rr1gtuV3Dk96+P2pJpQ1c1F
         K4hrBSgNFrOG/oqXvn5D7vhk6lLAhq8WvRh5GsGCew1+2XfMt1RXoBpB37EFQlIluFw8
         yCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NdZclFgXy4ov5FrjcRf48EixvIBPnhRXDS+1A+mdiw=;
        b=d+dortD93uuhwejfWeQc8kiZr1nwggLWs661cptfHUqBJEpzZp/5GUBifr5ygVwgB0
         1c7JFN+49Zq/Jn5YSv+x8pBUYLbSzlhiuB6jqqcIEgI/P9SGmYfdzX0pVT07Ac/U++4s
         VDrgS8uCZPzSgjvJl1Mfklm2YymVkX9cx1Rg14S00e2ZhdpeAr74/1d2SSbJxbRttZZC
         lZ8ONI9CxR/BlyeABHuCIBEkqIYQM9BB1hRaLIe1VRZzAHVF7fH10lYi/oEEdgMw8QL2
         YpReeb2003W6iHC+6w+rnFRfVSWFiA8R9Dvy+m0GrvzCsXFLwdQ8oBR1fMWhL+oY0Nzq
         qzVA==
X-Gm-Message-State: AO0yUKWQRf03ub2Pq4Anud8aBIQVM6GAoqtIYvx6NWPh6hEdEVdyomPb
        A5S9RQvwW1Fc33ktDm6ABW1z4YMol/E=
X-Google-Smtp-Source: AK7set+XOJBFlTfVofLhEpVxm8lbwbp0QAyXeWy/CdWIl6PU8a0OBP+RU/ZUZyxoOjHYAju2GzoB1g==
X-Received: by 2002:a17:906:2b99:b0:92d:145a:6115 with SMTP id m25-20020a1709062b9900b0092d145a6115mr9524569ejg.38.1679332522576;
        Mon, 20 Mar 2023 10:15:22 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906549000b009334d87d106sm2510357ejo.147.2023.03.20.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:15:22 -0700 (PDT)
Date:   Mon, 20 Mar 2023 18:15:20 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     landlock@lists.linux.dev, Tyler Hicks <code@tyhicks.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Does Landlock not work with eCryptfs?
Message-ID: <20230320.c6b83047622f@gnoack.org>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sun, Mar 19, 2023 at 10:00:46PM +0100, Mickaël Salaün wrote:
> Hi Günther,
> 
> Thanks for the report, I confirm there is indeed a bug. I tested with a
> Debian distro:
> 
> ecryptfs-setup-private --nopwcheck --noautomount
> ecryptfs-mount-private
> # And then with the kernel's sample/landlock/sandboxer:
> LL_FS_RO="/usr" LL_FS_RW="${HOME}/Private" sandboxer ls ~/Private
> ls: cannot open directory '/home/user/Private': Permission denied
> 
> Actions other than listing a directory (e.g. creating files/directories,
> reading/writing to files) are controlled as expected. The issue might be
> that directories' inodes are not the same when listing the content of a
> directory or when creating new files/directories (which is weird). My
> hypothesis is that Landlock would then deny directory reading because the
> directory's inode doesn't match any rule. It might be related to the overlay
> nature of ecryptfs.
> 
> Tyler, do you have some idea?

I had a hunch, and found out that the example can be made to work by
granting the LANDLOCK_ACCESS_FS_READ_DIR right on the place where the
*encrypted* version of that home directory lives:

  err := landlock.V1.RestrictPaths(
          landlock.RODirs(dir),
          landlock.PathAccess(llsys.AccessFSReadDir, "/home/.ecryptfs/gnoack/.Private"),
  )

It does seem a bit like eCryptfs it calling security_file_open() under
the hood for the encrypted version of that file? Is that correct?

–Günther
