Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2940A8E13C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfHNXcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 19:32:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50234 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfHNXcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:32:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hy2km-0001Ye-LK; Wed, 14 Aug 2019 23:32:28 +0000
Date:   Thu, 15 Aug 2019 00:32:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 03/11] fs: move __get_super() out of loop
Message-ID: <20190814233228.GU1131@ZenIV.linux.org.uk>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-4-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814121834.13983-4-s.hauer@pengutronix.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:18:26PM +0200, Sascha Hauer wrote:
> __get_super_thawed() calls __get_super() multiple times. I can't see a case
> where __get_super() would return another valid superblock when called
> again, so move the call to __get_super() out of the loop. This is done in
> preparation for the next patch.

How about "someone has come and unmounted the sucker under us"?
