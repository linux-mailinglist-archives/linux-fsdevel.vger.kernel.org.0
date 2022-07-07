Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3894556A8C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiGGQ6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiGGQ6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:58:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFEC28F;
        Thu,  7 Jul 2022 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ev9W6XXkwKM3vIjjlIyJLBaqOOrAF0wJTug4OZ3DvpY=; b=n+Uey5qFpx8vQvvDQZ/pDIJigK
        oY1+NogUWLvn5+ilgbw95hK0TzzlyB7zEcAt6mqzSSKBfWSB2MpKbgHdAPuM6G/wvhYuA4g51Dedi
        5ZWU6avqeqJukXWUtZ2nafZzXXgmoZZ7FcYq+YGuoHlRpcr7KDgSZpb/uhxPsL/lklDC5fnVgFrR6
        enDnXHS+ioz6801A7krjAv0y4ZdaEMHy/XDvbd7onfOmA8wUuByAasK9/FChNTK+MzrqulOrjPg3L
        LI9/2kNqGR+2nHKpPQS/W0ORGyY8ty/2UBKdCwgCeQKazdEOKG6mdKXEar5hMNyccfj8fVTA9lKov
        hkpuwCzA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9Uq1-00H6TB-Qr; Thu, 07 Jul 2022 16:58:49 +0000
Date:   Thu, 7 Jul 2022 09:58:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     bh1scw@gmail.com
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] kernel/sysysctl.c: Remove trailing white space
Message-ID: <YscQyaUIrSWxA3Ub@bombadil.infradead.org>
References: <20220516090752.2137286-1-bh1scw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516090752.2137286-1-bh1scw@gmail.com>
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

On Mon, May 16, 2022 at 05:07:53PM +0800, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> This patch removes the trailing white space in kernel/sysysctl.c
> Special thanks to Muchun Song.
> 
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Queued thanks.

  Luis
