Return-Path: <linux-fsdevel+bounces-196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92287C758B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 20:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB2B282C06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B538DDD;
	Thu, 12 Oct 2023 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8734CEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 18:00:37 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDBA9;
	Thu, 12 Oct 2023 11:00:35 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c8a6aa0cd1so10954265ad.0;
        Thu, 12 Oct 2023 11:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133635; x=1697738435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKdTAQn3XzGpY+ZUQb5LPKQnf1Hcd0mnfJpRNv4Os8M=;
        b=onV4ETD4N//+jrjlBwLysmkr9AXGC2f4m4RUUTQYBYoljHR0NEcHsquC0Nk4vxj6cU
         SrR5hCYygWsIOWJq0Q4GyPk/YWYoaFNgx41DSZFPe2Hemu1+YeTApUFs0s/oygyTiZVn
         VcZpzAtPV9u9Q1h6W6F3vG2k3UaSA2q/tMy6pwrc7IFiUj/uzo0SJOXxG5nfVP9vAIOI
         0cEhrtZMt1H/AYvTjDFq4lPTQMYfDSfhpyVbLy6rUSLEQ8eR79ds6PqFHawap8mzXGUn
         F5x1aw6f9x9NbODV0a22MivZH+FDY6A884mNktaJi1bHqcEWwBEYbimS4mVcd+DVVYmh
         lspg==
X-Gm-Message-State: AOJu0YyU7YvyffpfVUNl05DLZg8YWIBOq2Mu1kD7s+Ox6Za459jZtji1
	ZE6hSJ+vRQI1zNPB4TyR+xwLa+zbjVU=
X-Google-Smtp-Source: AGHT+IGyN4MZ/M2Jss6UPhOTXhh9Fgs9O3Po1iWNHBYd+0Kw+xv1jSQxnZ0byMtB9uGQJV/XAKRHDg==
X-Received: by 2002:a17:902:e5cb:b0:1c8:78b5:2ceb with SMTP id u11-20020a170902e5cb00b001c878b52cebmr27711014plf.40.1697133634801;
        Thu, 12 Oct 2023 11:00:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:414d:a1fb:8def:b3ee? ([2620:15c:211:201:414d:a1fb:8def:b3ee])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001c627413e87sm2315934plk.290.2023.10.12.11.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 11:00:34 -0700 (PDT)
Message-ID: <4fee2c56-7631-45d2-b709-2dadea057f52@acm.org>
Date: Thu, 12 Oct 2023 11:00:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
 <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
 <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 18:02, Damien Le Moal wrote:
> Some have stated interest in CDL in NVMe-oF context, which could
> imply that combining CDL and lifetime may be something useful to do
> in that space...

We are having this discussion because bi_ioprio is sixteen bits wide and
because we don't want to make struct bio larger. How about expanding the
bi_ioprio field from 16 to 32 bits and to use separate bits for CDL
information and data lifetimes?

This patch does not make struct bio bigger because it changes a three
byte hole with a one byte hole:

--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -268,8 +268,8 @@ struct bio {
                                                  * req_flags.
                                                  */
         unsigned short          bi_flags;       /* BIO_* below */
-       unsigned short          bi_ioprio;
         blk_status_t            bi_status;
+       u32                     bi_ioprio;
         atomic_t                __bi_remaining;

         struct bvec_iter        bi_iter;


 From the pahole output:

struct bio {
         struct bio *               bi_next;              /*     0     8 */
         struct block_device *      bi_bdev;              /*     8     8 */
         blk_opf_t                  bi_opf;               /*    16     4 */
         short unsigned int         bi_flags;             /*    20     2 */
         blk_status_t               bi_status;            /*    22     1 */

         /* XXX 1 byte hole, try to pack */

         u32                        bi_ioprio;            /*    24     4 */
         atomic_t                   __bi_remaining;       /*    28     4 */
         struct bvec_iter           bi_iter;              /*    32    20 */
         blk_qc_t                   bi_cookie;            /*    52     4 */
         bio_end_io_t *             bi_end_io;            /*    56     8 */
         /* --- cacheline 1 boundary (64 bytes) --- */
         void *                     bi_private;           /*    64     8 */
         struct bio_crypt_ctx *     bi_crypt_context;     /*    72     8 */
         union {
                 struct bio_integrity_payload * bi_integrity; /*    80 
   8 */
         };                                               /*    80     8 */
         short unsigned int         bi_vcnt;              /*    88     2 */
         short unsigned int         bi_max_vecs;          /*    90     2 */
         atomic_t                   __bi_cnt;             /*    92     4 */
         struct bio_vec *           bi_io_vec;            /*    96     8 */
         struct bio_set *           bi_pool;              /*   104     8 */
         struct bio_vec             bi_inline_vecs[];     /*   112     0 */

         /* size: 112, cachelines: 2, members: 19 */
         /* sum members: 111, holes: 1, sum holes: 1 */
         /* last cacheline: 48 bytes */
};

Thanks,

Bart.

