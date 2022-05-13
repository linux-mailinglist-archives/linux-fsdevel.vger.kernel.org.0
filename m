Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB17525915
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 02:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357287AbiEMAsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 20:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348071AbiEMAsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 20:48:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190357A470
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3w1o4k57AMx2dVtMBUK26TNdR1Ol03EU2KRj49KOP0I=; b=CWlGQQUcbQJoUm1yZip5SrBsnW
        bCMeVSJLrREvK32Dwt+M2Uv/fGtT9KTjVLgtvEDogbZxSMHcz8BsL/wBeL/kwEV/F1Ce3ND8mGivu
        gy3IbP+mtEkpoungspLFJZt1iZXwh3OlhXIciUfWbeYUPe3MYG8O1IdkddT3viX0Ma/DdwHy1cI4P
        1Sw9XjDVm901vAJzGZFqOhvmQesYDDADwJMsJAqlaARDEHoLfBS/LKAwWsbTmy7JyP8bltCfHeX2O
        kSWxU/ombDQwd8uN4JAsKVFPwhjXAPTM3ab5cx6K7FIpn0bYjLj2SnGiwI2YCZeb5ygsu0mo+a9xs
        O1FpWV4w==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npJTU-00ERjl-Ei; Fri, 13 May 2022 00:48:08 +0000
Date:   Fri, 13 May 2022 00:48:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCH] get rid of the remnants of 'batched' fget/fput stuff
Message-ID: <Yn2qyH0VzZAozfGc@zeniv-ca.linux.org.uk>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
 <Yn2Xr5NlqVUzBQLG@zeniv-ca.linux.org.uk>
 <c9d4df4e-f31d-1b6c-0d63-d1f2bf40929b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d4df4e-f31d-1b6c-0d63-d1f2bf40929b@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 05:48:08PM -0600, Jens Axboe wrote:
> On 5/12/22 5:26 PM, Al Viro wrote:
> > Hadn't been used since 62906e89e63b "io_uring: remove file batch-get
> > optimisation", should've been killed back then...
> 
> I'm pretty sure this has been sent out before, forget from whom.

Right you are...  From Gou Hao, had fallen through the cracks back in
November ;-/  Rebased and replaced my variant with it now...
