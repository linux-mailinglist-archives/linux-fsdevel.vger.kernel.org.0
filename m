Return-Path: <linux-fsdevel+bounces-1907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B217DFFAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 09:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607EA281DFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 08:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADCB847B;
	Fri,  3 Nov 2023 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B118468
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:19:13 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C6D43
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 01:19:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9810067373; Fri,  3 Nov 2023 09:19:08 +0100 (CET)
Date: Fri, 3 Nov 2023 09:19:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: make s_count atomic_t
Message-ID: <20231103081907.GD16854@lst.de>
References: <20231027-neurologie-miterleben-a8c52a745463@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027-neurologie-miterleben-a8c52a745463@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

Same feeling as Jan here - this looks fine to me, but I wonder if there's
much of a need.  Maybe run it past Al if he has any opinion?

