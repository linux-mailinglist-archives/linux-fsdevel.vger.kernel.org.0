Return-Path: <linux-fsdevel+bounces-50710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF91ACEAB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D2B189B11B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD501FDA8E;
	Thu,  5 Jun 2025 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="jqx3rsru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31FB1F7904;
	Thu,  5 Jun 2025 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749107411; cv=none; b=mIxPUHgqZMclvDAW62zg6boqTmfE6jz/jZ0Bi+RBjct/3R+CIoBmd3gSIbMZ4baQFZjZMsvu+K5X8LHhtbRvupxXjurLg7p3HSy8fUI9o118rVzgw7iE/hCUr3Jc0109HaVsxlLV7j81BLzAgQdJyhD0rXwMn+z0GBnoyFzL+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749107411; c=relaxed/simple;
	bh=/EhS3iHa3DPF4MPKsT0V/UOj/zPIgVbIWgFsrD5u17k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAShOVnSd28v0gyXlMhTt3f5IxPxDKOegMWkyWvPBT5HYiT6BmXCOPorJto3oRi2ccbXLCRlGtmuOIXc83RbL+1UmperQAyaJDP2vyqoYGY0IyyHNfHJpplfCB72yuVyYR/Q3VbenlxmycEEIE5nz6+lzpugiOGQISnz+xND0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=jqx3rsru; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 6D80B3C010853;
	Thu,  5 Jun 2025 00:10:03 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id JMlKYrDvSYZE; Thu,  5 Jun 2025 00:10:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 400CD3C010858;
	Thu,  5 Jun 2025 00:10:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 400CD3C010858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1749107403;
	bh=4Qd52nvGfr7jmIQAnAzXun6RFm1GlLqzHLP10c1wU98=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=jqx3rsruAduI1KhFul8QYF50IuBwjC390Ycg9t1hLNO3Sst5LufsaaIChChRMO/Ky
	 wLvudXXkaK7fPplCKHrnZt9jSWKQB/ajbxsjQeN2UxX+uaM038HGanrXBgSFtkdfZA
	 9J/NRgc+SKm4FzUnyp8urjiv0+BM2EJQdncmic4IwFLxS8s94xr0UICZfYowtfO8q5
	 t1nWWMQjmDZsgqSYmFUcyAYrsMsv86jn62qrhpMKVrUhQX7TwXMMFvxwGM+O5CBEy2
	 /X4naFvXE4MiwpJPM4SfjXkn3sptxrlwywxubjK0hCreQJhExpub7UV41dzap7fhEa
	 rjmOLitXRD4aA==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id K5XVMBTuZY3A; Thu,  5 Jun 2025 00:10:03 -0700 (PDT)
Received: from penguin.cs.ucla.edu (unknown [47.143.215.226])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 123A83C010853;
	Thu,  5 Jun 2025 00:10:03 -0700 (PDT)
Message-ID: <bc69175a-56db-4f76-b251-f560d8d32cbd@cs.ucla.edu>
Date: Thu, 5 Jun 2025 00:10:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recent Linux kernel commit breaks Gnulib test suite.
To: Collin Funk <collin.funk1@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, bug-gnulib@gnu.org
References: <8734ceal7q.fsf@gmail.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <8734ceal7q.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I saw that bug last month, and filed a Fedora bug report here:

https://bugzilla.redhat.com/show_bug.cgi?id=2369561

The kernel bug breaks libxattr's attr_copy_fd and attr_copy_file 
functions, among other things.

