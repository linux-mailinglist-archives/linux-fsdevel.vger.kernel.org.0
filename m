Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBCD134A01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 19:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgAHSBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 13:01:07 -0500
Received: from verein.lst.de ([213.95.11.211]:50551 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgAHSBH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:01:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4EC9F68BFE; Wed,  8 Jan 2020 19:01:05 +0100 (CET)
Date:   Wed, 8 Jan 2020 19:01:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com
Subject: Re: [PATCH v9 07/13] exfat: add bitmap operations
Message-ID: <20200108180105.GC14650@lst.de>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082405epcas1p41dd62d00104cb0daa4fe85641cb8ee22@epcas1p4.samsung.com> <20200102082036.29643-8-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-8-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
