Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8912DB96C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLPCs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 21:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLPCs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:48:26 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528FC0613D6;
        Tue, 15 Dec 2020 18:47:46 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpMqs-001ZB0-7u; Wed, 16 Dec 2020 02:47:42 +0000
Date:   Wed, 16 Dec 2020 02:47:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fget: Do not loop with rcu lock held
Message-ID: <20201216024742.GK3579531@ZenIV.linux.org.uk>
References: <20201215164123.609980-1-s.temerkhanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215164123.609980-1-s.temerkhanov@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 07:41:23PM +0300, Sergey Temerkhanov wrote:
> Unlock RCU before running another loop iteration

If you are able to keep it looping for a long time, I would really
like to see the reproducer.
