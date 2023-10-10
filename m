Return-Path: <linux-fsdevel+bounces-1-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC57C4111
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 22:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC66A1C20D3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82323158C;
	Tue, 10 Oct 2023 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WdSQ4LUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F431580;
	Tue, 10 Oct 2023 20:23:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8497094;
	Tue, 10 Oct 2023 13:23:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0223CC433C9;
	Tue, 10 Oct 2023 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696969380;
	bh=Ym/pxMbdvm247vTaNNOcOCuORilqXz04df7lVT2ORUM=;
	h=Date:From:To:Subject:From;
	b=WdSQ4LUy+sPEUUt1Kyz7iE86ijOhc3eQyXukBI12dF2xym/Fe9QCHZSFSaRiOfuI0
	 ciwvirbzHN6I44qJha9KH55vmB4UttjAyGtVEDp9mhD3YKYL/exL7EJ3ZMR7Xk8c4Z
	 YIqNHRj52/Iw2atIhSSoM7GnLNAFrzYBwZoJ1x5w=
Date: Tue, 10 Oct 2023 16:22:58 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: This list is being migrated to new infrastructure (no action
 required)
Message-ID: <20231010-triceps-flattery-228412@meerkat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, all:

This list is being migrated to the new vger infrastructure. This should be a
fully transparent process and you don't need to change anything about how you
participate with the list or how you receive mail.

There will be a brief delay with archives on lore.kernel.org. I will follow up
once the archive migration has been completed.

Best regards,
Konstantin

