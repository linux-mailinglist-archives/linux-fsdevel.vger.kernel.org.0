Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF05674C682
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGIRLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjGIRLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:11:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D00E7;
        Sun,  9 Jul 2023 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688922659; bh=85baKQVhUJwMNHoo9j6MY2P0J1fOuNxV8TCqZobjB9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKPMWBpCTl/nxOv/Dn/MOf64AU50QS2zbBYprRqxOqoEuhaRzfbbrjuHonX/55Rne
         HkXiS6uIbDajMYR6ZHyUcD92aXCyBWcbmx+EAMWSADIOGRRrI0pTqSqKXFnsbuTBBo
         bWVZEEVF34nt8CjRN21mfw0xKwk8Zp9+wXSOpUmI=
Date:   Sun, 9 Jul 2023 19:10:58 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709092947.GF9321@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,

On 2023-07-09 11:29:47+0200, Willy Tarreau wrote:
> On Fri, Jun 30, 2023 at 10:06:09PM +0800, Zhangjin Wu wrote:
>> [..]
> 
> Now queued, thanks!
> Willy

Don't we need an Ack from the fs maintainers for the patch to
fs/proc/proc_net.c ?

Personally I expected this series to go in via the fs tree because of
that patch.

Thomas
