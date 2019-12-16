Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650B811FCF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 03:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfLPCqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Dec 2019 21:46:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47263 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbfLPCqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:46:13 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBG2jtY0003194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Dec 2019 21:45:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5DD5D4207DF; Sun, 15 Dec 2019 21:45:55 -0500 (EST)
Date:   Sun, 15 Dec 2019 21:45:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH] jbd2: fix kernel-doc notation warning
Message-ID: <20191216024555.GC11512@mit.edu>
References: <53e3ce27-ceae-560d-0fd4-f95728a33e12@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e3ce27-ceae-560d-0fd4-f95728a33e12@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 08, 2019 at 08:31:32PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning by inserting a beginning '*' character
> for the kernel-doc line.
> 
> ../include/linux/jbd2.h:461: warning: bad line:         journal. These are dirty buffers and revoke descriptor blocks.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

						- Ted
