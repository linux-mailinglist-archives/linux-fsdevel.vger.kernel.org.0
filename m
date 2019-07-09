Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2862D2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 02:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfGIAwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 20:52:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36634 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGIAwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:52:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkeMm-0003fR-TC; Tue, 09 Jul 2019 00:52:20 +0000
Date:   Tue, 9 Jul 2019 01:52:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: Procedure questions - new filesystem driver..
Message-ID: <20190709005220.GZ17978@ZenIV.linux.org.uk>
References: <21080.1562632662@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21080.1562632662@turing-police>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 08:37:42PM -0400, Valdis Klētnieks wrote:
> I have an out-of-tree driver for the exfat file system that I beaten into shape
> for upstreaming. The driver works, and passes sparse and checkpatch (except
> for a number of line-too-long complaints).
> 
> Do you want this taken straight to the fs/ tree, or through drivers/staging?

First of all, post it...
