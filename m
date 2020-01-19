Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F0142070
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 23:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgASW1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 17:27:44 -0500
Received: from verein.lst.de ([213.95.11.211]:42054 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgASW1o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:27:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35AE468B20; Sun, 19 Jan 2020 23:27:42 +0100 (CET)
Date:   Sun, 19 Jan 2020 23:27:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com
Subject: Re: [PATCH v11 03/14] exfat: add inode operations
Message-ID: <20200119222741.GB4890@lst.de>
References: <20200118150348.9972-1-linkinjeon@gmail.com> <20200118150348.9972-4-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118150348.9972-4-linkinjeon@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 12:03:37AM +0900, Namjae Jeon wrote:
> From: Namjae Jeon <namjae.jeon@samsung.com>
> 
> This adds the implementation of inode operations for exfat.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
