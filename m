Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60E706FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjEQRuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEQRub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 13:50:31 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 10:50:29 PDT
Received: from p3plwbeout16-04.prod.phx3.secureserver.net (p3plsmtp16-04-2.prod.phx3.secureserver.net [173.201.193.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1DCBE
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 10:50:29 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id zLFWp4Nh3b397zLFXpx1yr; Wed, 17 May 2023 10:47:43 -0700
X-CMAE-Analysis: v=2.4 cv=XfBMcK15 c=1 sm=1 tr=0 ts=6465133f
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=FXvPX3liAAAA:8
 a=IoMjfNCK1isbzoXsNuIA:9 a=QEXdDO2ut3YA:10 a=SM4aVyO6fsoA:10
 a=UxLD5KG5Eu0A:10 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  zLFWp4Nh3b397
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.87])
        by smtp05.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1pzLFa-0006vm-O3; Wed, 17 May 2023 18:47:47 +0100
Message-ID: <6c9e3b5d-093f-b7b7-2370-04d3953dc9cd@squashfs.org.uk>
Date:   Wed, 17 May 2023 18:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] squashfs: don't include buffer_head.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, squashfs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230517071622.245151-1-hch@lst.de>
Content-Language: en-GB
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230517071622.245151-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfDQmMV5H0TZAUZ8qKdYriUUlbqZqPqTrxCvr9ALcT7ae9mYtwXcsexgTNFa1IS7Yq7rX0OzKkGTUScTV9OB35HTcZ3eZLX606lxzWY9jLGo6T5TpZfsX
 fge0FfNrZgBJq/C7kFPaAcHmlomSHg976uUZDCI2QtadD4rjNE2bzJT1tG8LDiUHBbzge0ym9lxQ/HsD+nAsWKifOPG9AFZB4NpIVl3gyfvedIacy6CKoAqw
 GxCRN6aps+p8f3VQuiL1ug==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/05/2023 08:16, Christoph Hellwig wrote:
> Squashfs has stopped using buffers heads in 93e72b3c612adcaca1
> ("squashfs: migrate from ll_rw_block usage to BIO").
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>


