Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426024E36C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 03:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiCVCn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 22:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiCVCn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:43:27 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4FF20198
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 19:42:00 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWUT8-00FBC2-Ph; Tue, 22 Mar 2022 02:41:58 +0000
Date:   Tue, 22 Mar 2022 02:41:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Haimin Zhang <tcs.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH] fhandle: add __GFP_ZERO flag for kmalloc in function
 do_sys_name_to_handle
Message-ID: <Yjk3dkW2Qt24IjQH@zeniv-ca.linux.org.uk>
References: <20220322021326.20162-1-tcs.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322021326.20162-1-tcs.kernel@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:13:26AM +0800, Haimin Zhang wrote:
> From: Haimin Zhang <tcs_kernel@tencent.com>
> 
> Add __GFP_ZERO flag for kmalloc in function do_sys_name_to_handle to
> initialize the buffer of a file_handle variable.
> 
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>

That's called kzalloc()...  Care to resend?
