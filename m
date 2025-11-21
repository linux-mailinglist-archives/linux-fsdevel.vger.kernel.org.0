Return-Path: <linux-fsdevel+bounces-69338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E4C76E60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 02:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AB8335CBF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283E24728F;
	Fri, 21 Nov 2025 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WrnK8NHt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9014AD0D;
	Fri, 21 Nov 2025 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690091; cv=none; b=TQsc1LtTHNOEjdqA2qi6UcTM4EbUMPU+pGAwWLgvTea0A0QSNBTmGz9N/vvz0Ou24XdOcZt+kCYTeBh5sJmI1CKBncFIxsxShiDL6rj84Dury6kGq3GUoT4DoliStaheB9tPm7/B6uHHjhdSriv1Z6SffgbqELtoLJEXr3kpSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690091; c=relaxed/simple;
	bh=mjXzwlPQuMvwfuoI6fyn1UE0PXw5yR0XdOPwuz9JfZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JTMA4sYjAcwleyrKnkhz2w8p1dTqhwWGwkQl6vvnCxSQi+hGesCuN5/ncB17m2BVKoNM0SbXFRqggvOntqIhovzZ9Ucj+mGWWy4X1jcjxk3vubIxTb1Mimkcx16IgGGPW6+aaZg3MSptNALAvTWil0eg5FSE6EQ2d+4UrP4CNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WrnK8NHt; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763690081; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mjXzwlPQuMvwfuoI6fyn1UE0PXw5yR0XdOPwuz9JfZU=;
	b=WrnK8NHtTPmJe25VDPWP0ip2jESxlMSmZzH1WlpJ3TWOll4TL17SoeVvVKgrBxdN7lV6V8oAwLkXNEjLXmp7DZF4d47DDyY86OBvSBAs/eXIB++kDEMnXCU5YGQtnoxjbfAhlkIIdEoq8PPrU5Dpvgl/CtGDLb65tgbbix8wPwE=
Received: from 30.221.131.79(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsyeYvn_1763690079 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 09:54:40 +0800
Message-ID: <eec31850-c012-4200-8a0a-4dff5a901720@linux.alibaba.com>
Date: Fri, 21 Nov 2025 09:54:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] WARNING in dax_iomap_rw
To: syzbot <syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
References: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, nvdimm@lists.linux.dev,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz set subsystems: fs
#syz fix: dax: skip read lock assertion for read-only filesystems

