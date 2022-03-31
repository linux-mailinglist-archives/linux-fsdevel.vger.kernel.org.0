Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E84EDBC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbiCaOid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiCaOid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:38:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A2D1F2DCE;
        Thu, 31 Mar 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UGRMOLjwh8wFQwrWEciThniTblcQYyyZ5Zuat0kWF2k=; b=vT/Khf0Emk8pujLkmWbN5i3gLt
        MkldrB9B3A498Acx1KdF5UJpwvpebOOADBSNlvOf284u22s8GpuaHezuOl0/FIfsuzcC49XFVhvaX
        Ff0lPy4HhpSBegK52jRjPu/kPRtdvUUotQsEUkDxJJMTjfGZlV4J9A0jK2JbrK9ET5wbUmH+LwIB2
        evrzLI1KRPm0x3jt3Qam9yXxR5KXn8wrAcl15HHA5G5cxU+JBfNZiYPbggH+yiA2D1qngvOdmLYbB
        x3Wtrr9J9LaoB9UK0APeoe7s3F7JAyGmNntF0tpRVZmq0eFkkK86yaZw8vEGbsDlRfT1W4MI8vhiG
        zRQEsLfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZvuh-002KH2-9f; Thu, 31 Mar 2022 14:36:39 +0000
Date:   Thu, 31 Mar 2022 15:36:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 0/4] Convert vmcore to use an iov_iter
Message-ID: <YkW8d/HuXewjSuXs@casper.infradead.org>
References: <20220318093706.161534-1-bhe@redhat.com>
 <YkWPrWOe1hlfqGdy@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkWPrWOe1hlfqGdy@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:25:33PM +0800, Baoquan He wrote:
> Hi Andrew,
> 
> On 03/18/22 at 05:37pm, Baoquan He wrote:
> > Copy the description of v3 cover letter from Willy:
> 
> Could you pick this series into your tree? I reviewed the patches 1~3
> and tested the whole patchset, no issue found.

... I'd fold patch 4 into patch 1, but yes, Andrew, please take these
patches.
