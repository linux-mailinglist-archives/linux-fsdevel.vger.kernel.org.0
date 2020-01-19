Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726F6142084
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 23:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgASWiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 17:38:02 -0500
Received: from verein.lst.de ([213.95.11.211]:42113 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgASWiC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:38:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 08B0668B20; Sun, 19 Jan 2020 23:37:59 +0100 (CET)
Date:   Sun, 19 Jan 2020 23:37:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com
Subject: Re: [PATCH v11 14/14] staging: exfat: make staging/exfat and
 fs/exfat mutually exclusive
Message-ID: <20200119223758.GH4890@lst.de>
References: <20200118150348.9972-1-linkinjeon@gmail.com> <20200118150348.9972-15-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118150348.9972-15-linkinjeon@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 12:03:48AM +0900, Namjae Jeon wrote:
> From: Namjae Jeon <namjae.jeon@samsung.com>
> 
> Make staging/exfat and fs/exfat mutually exclusive to select the one
> between two same filesystem.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
