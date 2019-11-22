Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28A107624
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 18:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKVRCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 12:02:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47150 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:02:06 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYCJm-0000wX-Rm; Fri, 22 Nov 2019 17:02:02 +0000
Date:   Fri, 22 Nov 2019 17:02:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de
Subject: Re: [PATCH v3 03/13] exfat: add inode operations
Message-ID: <20191122170202.GE26530@ZenIV.linux.org.uk>
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094021epcas1p16e9ebb9fd8a1b25c64b09899a31988b9@epcas1p1.samsung.com>
 <20191119093718.3501-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119093718.3501-4-namjae.jeon@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 04:37:08AM -0500, Namjae Jeon wrote:
> This adds the implementation of inode operations for exfat.

Could you explain where is ->d_time ever read?
