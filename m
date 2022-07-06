Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71795694D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiGFV6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 17:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiGFV6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:58:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260A29806;
        Wed,  6 Jul 2022 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FWlecqAhe1wWW/g+l8SEjNxoVOaJ+w151+OPRHlFn0g=; b=nX0STgrRuA+QEENyN0xAm334CU
        B8JmUkMJG4g6dKkm1SMpYhgri+6U0M+P7Egy7XQU/q7s6prD/mbd402VR6bZLU1gOAbf+bs7nDjNl
        DMuJEQhZyEOvGbZnCy8q2Z34Gwj5ns5Y4XUt2qz/8idocv4u9Wi5ZHneKr9BmeXJ4CzfLIAllot4E
        Be4KJPoZH9CG/AciokXIFVmZCi1NRPsim1PAnBpSyanInU+TtPHm/VCakydY5FP2fppYmLrZxnUi0
        24YCnmmxUTdMNZDfUc143xlSfosOGjKXJ3gICtbyRmgqDzEb9U/qtrTHCQQcuBquEssDa3fHX/9cq
        vws4tEWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9D1x-00CVrT-B0; Wed, 06 Jul 2022 21:57:57 +0000
Date:   Wed, 6 Jul 2022 14:57:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] fs/dcache: export d_same_name() helper
Message-ID: <YsYFZU2Y2hkyVT3r@bombadil.infradead.org>
References: <20220526011737.371483-1-xiubli@redhat.com>
 <20220526011737.371483-2-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526011737.371483-2-xiubli@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 09:17:36AM +0800, Xiubo Li wrote:
> Compare dentry name with case-exact name, return true if names
> are same, or false.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
