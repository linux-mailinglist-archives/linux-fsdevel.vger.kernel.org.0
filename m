Return-Path: <linux-fsdevel+bounces-8371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C878357DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 22:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C74B211CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B7F38DDE;
	Sun, 21 Jan 2024 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="X7PxXLgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320238DD1;
	Sun, 21 Jan 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705870884; cv=pass; b=Uok8Ry79SNBT3LLW5jCD8Y8r23XzLiKN7V/A14C2wqg2K0b8kp8OPgZTtIMjLiBw3o+PnH20MbG+nYYtaphUcNGe+fl6no/eYggBp3OwALmS9N6QAY15DJkVAiLcjtqXYdrtzKV6zJTyxT9/LfaOHP/2bsvm75AR+sLMdSYGCEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705870884; c=relaxed/simple;
	bh=U0WuxNzw4dvsaQsByPRR3tvCqk37QbOjbRV9ABa0kS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQk8C/peN5kuOa1RBaNhvfpKW8wu1bXK/3cve9hAPr4uLX0IvA5Q88fPt9XxhPfMiGvojrzpPr3/3861uJVL98+3ZTY1zul7z4wqd7wN2zd/o24WzA8uFEXmk3kKTrOvb1aIAJw2GZUU97yXVtM9HL/gHWsJsCTJuNTIt69gngY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=X7PxXLgh; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1705870858; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OAou5tBGQaAkrIC2JLHJDAVN3pXnklTwFZk8A2OSdcxojcBClCAQkCVVrjU6BrtyINx9edZixdsHfQnKEKGCUppYhY6V4f60lujEXh4YcPDD3P97somiwSsyBJrsbzcLF7bu0uQAr9KT2i3bI1K25kidihann5ZybV23iWFHvzc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705870858; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZWN1X9h1FXxgBF/iHi47Bj01SXmXy/ewxHqhUfVR0Fs=; 
	b=XIS2zx76qotUTbHqx19DlNEy0BTDvTl+ruGQWwF8b6qBI+eozQnsVuKUH+jT+EHP9NkH56q64q5e9/qeuhsAn8dXPT/GZ/wupzw10l32e4qezBytImEs5hmcUi0LwpmuVPZN6rwokJe+REcu4SzB12f14j3E2dtzIMQWlzLI4AY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705870858;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ZWN1X9h1FXxgBF/iHi47Bj01SXmXy/ewxHqhUfVR0Fs=;
	b=X7PxXLghJZ9rJr87TL09IgA0e20tkzX9HMHkJz0j/f8aiYB/oDljPrvEfAFhS9Vf
	+1iyKmMcTZH4FQoEftfRv//MRlht9DizYVCP9WHvQDmrGcuhhu5nxUkgst6vEu4WPYe
	VlDGjFUylWVV9ASN0zBwLPdTT6ZjXIQs8dHHTwj0=
Received: from localhost.localdomain (212.73.77.98 [212.73.77.98]) by mx.zohomail.com
	with SMTPS id 170587085701579.9329690828846; Sun, 21 Jan 2024 13:00:57 -0800 (PST)
From: Askar Safin <safinaskar@zohomail.com>
To: wedsonaf@gmail.com
Cc: brauner@kernel.org,
	gregkh@linuxfoundation.org,
	kent.overstreet@gmail.com,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	walmeida@microsoft.com,
	willy@infradead.org
Subject: Re: [RFC PATCH 07/19] rust: fs: introduce `FileSystem::read_dir`
Date: Mon, 22 Jan 2024 00:00:49 +0300
Message-ID: <20240121210049.3747-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231018122518.128049-8-wedsonaf@gmail.com>
References: <20231018122518.128049-8-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227f660e6f6cf06fd251e7b68390000673d79edf5cb6ddea49eaad7f340efb310d7737fdee431f8ab:zu080112276cadbb7e55cfe6c4b29a873f000069b5e9b330a61bab5b1287e35533dea1d05ad35770c5f4eb2d:rf08011226111e05f3a46b612d04829a8400007cc907ac9e01a2005c5904f67b1b743930371cc432c60ef9:ZohoMail
X-ZohoMailClient: External

Wedson Almeida Filho:
> +    /// White-out type.
> +    Wht = bindings::DT_WHT,

As well as I understand, filesystems supposed not to return
DT_WHT from readdir to user space. But I'm not sure. Please,
do expirement! Create whiteout on ext4 and see what readdir
will return. As well as I understand, it will return DT_CHR.

So, I think DT_WHT should be deleted here.

Askar Safin

