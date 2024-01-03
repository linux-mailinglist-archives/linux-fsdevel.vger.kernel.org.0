Return-Path: <linux-fsdevel+bounces-7251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A788D823583
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F66CB238F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FA91CA8B;
	Wed,  3 Jan 2024 19:22:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8B1CA82;
	Wed,  3 Jan 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id 8E1AD140DED0F;
	Wed,  3 Jan 2024 11:22:28 -0800 (PST)
Date: Wed, 3 Jan 2024 11:22:28 -0800 (PST)
From: "Carl E. Thompson" <cet@carlthompson.net>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Message-ID: <1377749926.626.1704309748383@mail.carlthompson.net>
In-Reply-To: <cgivkso5ugccwkhtd5rh3d6rkoxdrra3hxgxhp5e5m45kn623s@f6hd3iajb3zg>
References: <i6ugxvkuz7fsnfoqlnmtjyy2owfyr4nlkszdxkexxixxbafhqa@mbsiiiw2jwqi>
 <3EB6181B-2BEA-49BE-A290-AFDE21FFD55F@dubeyko.com>
 <mpvktfgmdhcjohcwg24ssxli3nrv2nu6ev6hyvszabyik2oiam@axba2nsiovyx>
 <74751256-EA58-4EBB-8CA9-F1DD5E2F23FA@dubeyko.com>
 <cgivkso5ugccwkhtd5rh3d6rkoxdrra3hxgxhp5e5m45kn623s@f6hd3iajb3zg>
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev53
X-Originating-Client: open-xchange-appsuite


> On 2024-01-03 9:52 AM PST Kent Overstreet <kent.overstreet@linux.dev> wrote:

> ...

> > Could ZNS model affects a GC operations? Or, oppositely, ZNS model can
> > help to manage GC operations more efficiently?
> 
> The ZNS model only adds restrictions on top of a regular block device,
> so no it's not _helpful_ for our GC operations.

> ...

Could he be talking about the combination of bcachefs and internal drive garbage collection rather than only bcachefs garbage collection individually? I think the idea with many (most?) ZNS flash drives is that they don't have internal garbage collection at all and that the drive's erase/write cycles are more directly controlled / managed by the filesystem and OS block driver. I think the idea is supposed to be that the OS's drivers can manage garbage collection more efficiently that any generic drive firmware could. So the ZNS model is not just adding restrictions to a regular block devices, it's also shifting the responsibility for the drive's **internal** garbage collection to the OS drivers which is supposed to improve efficiency.

Or I could be completely wrong because this is not an area of expertise for me.

Carl

