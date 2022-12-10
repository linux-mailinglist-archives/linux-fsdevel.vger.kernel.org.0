Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1F64918B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 00:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLJXjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 18:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJXjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 18:39:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89EA12AC5;
        Sat, 10 Dec 2022 15:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P+spEQ7y7ZasIxb9ryrQ8rQPt1SUgFzIVniakYJnQDA=; b=BbZev/yZ9MElz9Qciq0BWl3CaP
        YvNPVKoowz1lJpyXpdl9qFxTsH5r0hjH34FAwT1/+v0az8xNpWUMxmi2HFA7YBOQnMK0lVi/2ztwL
        WpQDRgFb1r6S6WZCirFKuZs+oGtKSSrCOD1aJ92i3dRcHd4Vf48kVpzqGZ3bCECoAoK5IvVIFMytS
        p3BEi1mukSRwkJzmfOv8WA+MRk4UhQyRqHl0mOAy+RLNqp5n4g2J5kNIk2FDPIHu+JU3z09vOQ/Jy
        kQCJrLkkZR+ga6Nusgp1NWfU0dyyBD9WTtplasVrYYY0UGWF2xu0l5nLJS+QbxDrGB7ERQ9/eVztZ
        yGIz2QQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p49RP-00AuJN-2N;
        Sat, 10 Dec 2022 23:39:35 +0000
Date:   Sat, 10 Dec 2022 23:39:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mount: rebuild error handling in do_new_mount
Message-ID: <Y5UYt538lOFTwr5R@ZenIV>
References: <20221204150006.753148-1-nashuiliang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204150006.753148-1-nashuiliang@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 04, 2022 at 11:00:05PM +0800, Chuang Wang wrote:
> When a function execution error is detected in do_new_mount, it should
> return immediately. Using this can make the code easier to understand.

Your piles of goto make it harder to follow and reason about.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
