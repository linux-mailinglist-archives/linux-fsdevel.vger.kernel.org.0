Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC197108D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjEYJ2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjEYJ2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 05:28:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980AA191
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 02:27:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 848BA68B05; Thu, 25 May 2023 11:27:56 +0200 (CEST)
Date:   Thu, 25 May 2023 11:27:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yihuan Pan <xun794@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        vgoyal@redhat.com, hch@lst.de
Subject: Re: [PATCH] init: remove unused names parameter in split_fs_names()
Message-ID: <20230525092755.GA27586@lst.de>
References: <4lsiigvaw4lxcs37rlhgepv77xyxym6krkqcpc3xfncnswok3y@b67z3b44orar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4lsiigvaw4lxcs37rlhgepv77xyxym6krkqcpc3xfncnswok3y@b67z3b44orar>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So it turns out my do_mounts.c rework touched a lot of code, but does
not actually conflict with this patch.  Can you plese reflow your
commit message to not exceed 73 lines and resend?

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
