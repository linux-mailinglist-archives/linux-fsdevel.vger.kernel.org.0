Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04417514F49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378374AbiD2P3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378366AbiD2P3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:29:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393960A93;
        Fri, 29 Apr 2022 08:25:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A3467713E; Fri, 29 Apr 2022 11:25:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A3467713E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651245958;
        bh=HjTbolddBpOhLCa7WljZ0hEmZz3yFNAqpPeG2SPWBbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPv25SWaKLdS72zNTP52MvaVggO/cdILOcOWxr8YbETfbkq5lOJYqkQkU2adDHkaI
         QtdFKwD6YOXQ+EbUjh84amVP90uSCEO/8xUJyDG1y+wPEBdFbsvU/rwTbWfm7tn6U9
         Y22cDnDYhQLswXOJHJx8IZmmWTAso58HmN6pQk34=
Date:   Fri, 29 Apr 2022 11:25:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v23 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220429152558.GG7107@fieldses.org>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Except for comments on particular patches, this looks ready as far as
I'm concerned.

--b.
