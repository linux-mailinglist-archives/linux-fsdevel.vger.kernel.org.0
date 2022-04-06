Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47684F6DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 00:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiDFW1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiDFW1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:27:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E1208C13;
        Wed,  6 Apr 2022 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=MjQLm5nfhITl+A+kGiB/u0iJl9TpEsfjfRBNBNc7vN8=; b=tMmcIUHKkBdtg7T7s9K67UPUG7
        zXuomUFHe0YMuv7OC+i6C02oSFzYR5lTRzE/SCn/ZgAeeRbjZSYL63VrRfSTlfaCHqtf3Kww/r59U
        YvF/F+NyYhAUBJK14kT7HaYa/VXBDxpFZdiKVtsOFbsAH5iudMS0IqiRQgS051UZAqI40pv1FNi5F
        fIBUltS2SKbJuM+4gD8fUBk9Cx/vOYkiqoYYI91Eh9cmGGiCp9Nf4m8cM/Ju/cdQ+YM2Hj7f9Fw3v
        J0rvG/sVLc6SKEyTk+JLybWl0XkVY5h+nGGxAReQSXVUF4+Zg1p5Fjwhp+FPE10J6lhGSmJZyiLRy
        NDvdlXzA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncE5w-0088EA-Jw; Wed, 06 Apr 2022 22:25:44 +0000
Date:   Wed, 6 Apr 2022 15:25:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com
Subject: Re: [PATCH v2 10/11] fs/drop_caches: move drop_caches sysctls to its
 own file
Message-ID: <Yk4TaF0js35rRlVF@bombadil.infradead.org>
References: <20220221061018.10472-1-tangmeng@uniontech.com>
 <YhqVW972rnF5L22U@bombadil.infradead.org>
 <d610e715-7806-18db-8551-0d0c2f71cbb6@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d610e715-7806-18db-8551-0d0c2f71cbb6@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:48:06AM +0800, tangmeng wrote:
> 
> 
> On 2022/2/27 05:02, Luis Chamberlain wrote:
> 
> > 
> > Thanks but please send a v3 including all the other patches as well
> > and collecting the Reviewed/Acked-bys, etc. This can be sent *after*
> > your v3 of the optimization work.
> > 
> I have noticed that there is a conflict between sysctl-next and linux-next.
> Do I resubmit the patch based on linux-next, or after you deal with the
> conflict between sysctl-next and linux-next, I resubmit based on
> sysctl-next？

You can use sysctl-next now to base your development changes. Feel free
to send more changes.

  Luis
