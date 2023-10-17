Return-Path: <linux-fsdevel+bounces-577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC19E7CD006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 00:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E39B212AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E032F522;
	Tue, 17 Oct 2023 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKp0jfg+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8042F52D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 22:31:17 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997A8BA;
	Tue, 17 Oct 2023 15:31:16 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-457c7177a42so1994387137.2;
        Tue, 17 Oct 2023 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697581875; x=1698186675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEdo/IXrUIEoUHUCXW+U91HMMI7R0F6XSMyAesChus0=;
        b=SKp0jfg+glJZ87GVUGugRHbU0EBgUEt7gZ5a3xblz3LBKIQxJvXhL4BifmDRo3Vgkt
         KLhCTFEHnpkeeaVtoyfNYIJCKGFZjtkOrcVRPRWM6FybJmDICKF9EtVnT95Md1b+3Sbu
         3shqGa832A+BmdJwfdAoUPTAU2IKJ3HpHnPrgVqcpxNCu1nn8SfsZjWX6nnNjuX2zfK+
         gZdjmdRVjmQpwpnZm5mDpMJ1iU1n1TqpGJ3gEz0sZNHcOpiqnN7874BwaMcaalxOOQja
         mnTdt1dgW0B9AS0anOwnooWwFe4NPMmNQzSzoOusLVprh/X9TLNhRkCXKAwtNkhh+oZ3
         dGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697581875; x=1698186675;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEdo/IXrUIEoUHUCXW+U91HMMI7R0F6XSMyAesChus0=;
        b=jM8PxkPU/tf3gyL2heRknuh7Z1+gOS5KFdCE/bBetfSW8UeUm2m+ZM+W7k1PUB0Q6E
         BtO0tGXF7FqtOhpa92safWddes334E/POFFp0zbANNlInGw//e1KkVKMwoc7muEwIS/1
         d51o1uFlFjN8+U1Jm8R4U2yPBW0eib5ujbKdBc0wocHDKwKSaFUOHhSrIA76sc938exi
         o5Df+jn5gGGSRy53Bi4VpKrRweQ9PaqIac0OP124Uw7DR0vKBR5TX7sHss18XWqtLsF8
         80O0j7Wvu4uVgs8MvkNGmmqjNa9lJqWSTJmWbT+s3NXgjf/P7gZn1gevB9zBjlzh9WEq
         OfFw==
X-Gm-Message-State: AOJu0YzniUtn9QG5LKVTG7Rn+55jfva9oudOObZL+pFLkPnNSNE607rG
	Ff5g/eE5BV7J+FKYGUnUnsqhZtj/qcWPJBDVyzK3WQeEJeQ=
X-Google-Smtp-Source: AGHT+IG04PskU4tI0kwAZpFlSgCBYttHxRqtRZNOMql9fLhu3o2BuP5ehfAYs0OlSDftVhqufFykXArHTl2r8ZP2rZM=
X-Received: by 2002:a67:c187:0:b0:457:e9fe:66b with SMTP id
 h7-20020a67c187000000b00457e9fe066bmr4328066vsj.2.1697581875578; Tue, 17 Oct
 2023 15:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Klara Modin <klarasmodin@gmail.com>
Date: Wed, 18 Oct 2023 00:31:04 +0200
Message-ID: <CABq1_vgwYJpqKkWzw4U=s-fmZ94Tzu6wCXxw=O84wX6bf0WFfA@mail.gmail.com>
Subject: [BUG] vfat garbled mtimes (e57260ae3226bda354e6e5c838c62a6a88c2c5bc)
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jlayton@kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

https://lore.kernel.org/r/20231004185347.80880-35-jlayton@kernel.org
causes garbled mtimes for me on vfat.

(next-20231017, e57260ae3226bda354e6e5c838c62a6a88c2c5bc fat: convert
to new timestamp accessors)

Kind regards,
Klara Modin

Examples:
# touch test && sync && ls -l && stat test
total 0
-rwxr-xr-x 1 root root 0 20 jan  -3904093 test
  File: test
  Size: 0             Blocks: 0          IO Block: 4096   regular empty file
Device: 8,17    Inode: 4           Links: 1
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2023-10-17 02:00:00.000000000 +0200
Modify: -3904093-01-20 12:54:32.134624768 +0053
Change: 2023-10-18 00:05:50.000000000 +0200
 Birth: 2023-10-17 23:07:39.500000000 +0200
# touch test && sync && ls -l && stat test
total 0
-rwxr-xr-x 1 root root 0 26 maj  1916 test
  File: test
  Size: 0             Blocks: 0          IO Block: 4096   regular empty file
Device: 8,17    Inode: 4           Links: 1
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2023-10-17 02:00:00.000000000 +0200
Modify: 1916-05-26 13:50:39.*(0'(*(,- +0200
Change: 2023-10-18 00:06:10.000000000 +0200
 Birth: 2023-10-17 23:07:39.500000000 +0200

