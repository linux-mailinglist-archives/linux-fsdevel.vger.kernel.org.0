Return-Path: <linux-fsdevel+bounces-67004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86EC33046
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 22:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CECB18C3709
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433562ECD3A;
	Tue,  4 Nov 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="AOGvBCcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8E23A9AE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291242; cv=none; b=In3u9NteRS3/YwE5La2xijCb0ruTa2kUjvK4gN/+SQN6yPB4qkNZzXwvNC2i91FHvTexThCX+O9r414dxsXutfMRVVMpHYm46KAqYz7xtXX1NhRv4MCRe4zLD1L81bj/j3vXGlXqG+c/FegMwHNzqCsYh6+otLODgkKksof3cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291242; c=relaxed/simple;
	bh=FRx4Hnu2jOMJO9i9VK1lEjRTlDtsvrMhXGfxtVk7/T0=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ErvI7dZEQXYrew8ZSz6XRfVe3D5CfXXgLqEu5zveIGFcL83II6kxvnFuROEhhQLXDlIuXpg7D/2g+4HsQ2kmfqPoUauQ3hGAUo9uBwS2KoCgYgOaQRz5KDZyEI0OXET0kPcMRsld8xndxKPb+wl1v1w1PbEO1a3xIViGfhSaQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net; spf=pass smtp.mailfrom=msa.hinet.net; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=AOGvBCcY; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msa.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A4LKU7K809223
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Wed, 5 Nov 2025 05:20:33 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1762291233; bh=polh7vR8wqAdOdx9tGjY9sA6JRw=;
	h=From:To:Subject:Date;
	b=AOGvBCcYnwyjlZx6EjAx0OWgqavXNrM5t711TXD3V80xBZVB1NyrI2itig0WAYaZn
	 SKXlQltWzsWl0T/b/3WJA5cOdkW+zplTiAhTy3FkUIvppZ1fkdR4Ejk6XuJ+HWXqvZ
	 c3OyZKFPnoqm7SbGmco+mhVWtwCJ+qdLse3jdoNc=
Received: from [127.0.0.1] (1-161-146-9.dynamic-ip.hinet.net [1.161.146.9])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A4LEfNv027471
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Wed, 5 Nov 2025 05:18:22 +0800
From: Procurement 24658 <Linux-fsdevel@msa.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: Procurement <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TkVXIFBPIDY4MjE2IFR1ZXNkYXksIE5vdmVtYmVyIDQsIDIwMjUgYXQgMTA6MTg6MjEgUE0=?=
Message-ID: <deba2113-f08b-27a5-ae71-be98e03fffd9@msa.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Nov 2025 21:18:22 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=e6elSrp/ c=1 sm=1 tr=0 ts=690a6d9f
	a=YTsCnMS8cMDXS1rCUQZcyg==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=gC9GVpDSHrDkGow57TMA:9 a=QEXdDO2ut3YA:10

Hi Linux-fsdevel,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

Noble alliance trade

