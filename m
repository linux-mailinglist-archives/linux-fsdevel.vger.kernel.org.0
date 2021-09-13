Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1165F408CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbhIMNWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 09:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239178AbhIMNVA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:21:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 510B2610F9;
        Mon, 13 Sep 2021 13:19:26 +0000 (UTC)
Date:   Mon, 13 Sep 2021 15:19:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seq_file: mark seq_get_buf as deprecated
Message-ID: <20210913131924.fc6f6663ky3nikbg@wittgenstein>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:09AM +0200, Christoph Hellwig wrote:
> This function pokes a big hole into the seq_file abstraction.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Good idea.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
