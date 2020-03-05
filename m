Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2213B17AA45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCEQMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 11:12:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46696 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCEQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:12:34 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9t6q-005nfb-Qx; Thu, 05 Mar 2020 16:12:29 +0000
Date:   Thu, 5 Mar 2020 16:12:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, torvalds@linux-foundation.org
Subject: Re: [PATCH v14 00/14] add the latest exfat driver
Message-ID: <20200305161228.GU23230@ZenIV.linux.org.uk>
References: <CGME20200302062613epcas1p2969203b10bc3b7c41e0d4ffe9a08a3e9@epcas1p2.samsung.com>
 <20200302062145.1719-1-namjae.jeon@samsung.com>
 <20200305155324.GA5660@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305155324.GA5660@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:53:24PM +0100, Christoph Hellwig wrote:
> Al,
> 
> are you going to pick this up, or should Namjae go through the pains
> of setting up his own git tree to feed to Linus?

I'm putting together #for-next right now, that'll go there.

Al, cursing devpts, audit, ima, fsnotify and a lot of other unsavory things
right now...
