Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCAC50E78E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiDYR4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 13:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiDYR4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:56:32 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB8107723;
        Mon, 25 Apr 2022 10:53:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 89041713F; Mon, 25 Apr 2022 13:53:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 89041713F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650909207;
        bh=/iUoBiInkV+ApouOd1Z9x3rF0mKbkNgouDDPyMB3ql8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zBgJV7ZUJRoQDLGOvN1D7bh6I5N15nhmgnV8Hc/q34+WMctM9OFB7MCaul2TwUlsP
         +bNYNKfRZUlgY1TMFUQVMJCnbV8wUA4vuUoARRVf2hQSPyoQ7OocMK34vgDE4ZtuZu
         l4JmvlHH9A/whvew7mbpsN0aVRA2bSvlU04NUgxQ=
Date:   Mon, 25 Apr 2022 13:53:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v21 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220425175327.GD24825@fieldses.org>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <20220425161722.GC24825@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425161722.GC24825@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm getting a few new pynfs failures after applying these.  I haven't
tried to investigage what's happening.

--b.

**************************************************
RENEW3   st_renew.testExpired                                     : FAILURE
           nfs4lib.BadCompoundRes: Opening file b'RENEW3-1':
           operation OP_OPEN should return NFS4_OK, instead got
           NFS4ERR_DELAY
LKU10    st_locku.testTimedoutUnlock                              : FAILURE
           nfs4lib.BadCompoundRes: Opening file b'LKU10-1':
           operation OP_OPEN should return NFS4_OK, instead got
           NFS4ERR_DELAY
CLOSE9   st_close.testTimedoutClose2                              : FAILURE
           nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1':
           operation OP_OPEN should return NFS4_OK, instead got
           NFS4ERR_DELAY
CLOSE8   st_close.testTimedoutClose1                              : FAILURE
           nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1':
           operation OP_OPEN should return NFS4_OK, instead got
           NFS4ERR_DELAY
