Return-Path: <linux-fsdevel+bounces-3556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EDA7F65D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167C7281C41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E849F81;
	Thu, 23 Nov 2023 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgn4XzcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397853D39F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 17:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BAEC433C7;
	Thu, 23 Nov 2023 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700762181;
	bh=iN0GKxUWpjlZifZZDlclhiRokCXf0Vyhyx7QT0dJjjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgn4XzcMqWfYjAMRA3pAIqsStobTSRjAGfs61eaoA4EcOb9K91HH9B8GB+HzkuxOz
	 3GgTTDCqII42vgVcO96CCGcg37NZxjFoM1BwAV78fOh3UmtO1yF1PKTnjtDysbnu71
	 uYZtLqYRadkkWsY5p++eXaNorcv6X4Esi3qde6r9CwfGVMtuQIfjhjSIAqtKHdhJC0
	 wKbzKpz7FJyRqHKIWpy73kc7SuOih+VJPCeLoXp6kLJXfQaH1WzvrQbqaaWH5NgW5N
	 1RpzhmUmOJ5K/1p5sURLye+w7vo2TpEFkU3ml9+XvmBuZzM3sIopOtL1rwxoA38Eo3
	 URnrS6eWlMlJQ==
Date: Thu, 23 Nov 2023 18:56:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from
 iter_file_splice_write()
Message-ID: <20231123-geeicht-seegang-4a12e43cc8eb@brauner>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-6-amir73il@gmail.com>
 <ZV8Dk7UOLejEhzQN@infradead.org>
 <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
 <ZV9sTfUfM9PU1IFw@infradead.org>
 <CAOQ4uxiDbGCn3vB4VwQyzdE9k8JjCeMGOqsVN=J5=-KCkvuQ2g@mail.gmail.com>
 <20231123-geboren-deutlich-b5efc843f530@brauner>
 <CAOQ4uxhteMfu+mo1Y-mpF8+92X4MwXw0CNajoCDhBQLP02GYTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhteMfu+mo1Y-mpF8+92X4MwXw0CNajoCDhBQLP02GYTA@mail.gmail.com>

> Stating the obvious - please don't forget to edit the commit message
> removing mention of the helper.

Done. See vfs.rw.

