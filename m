Return-Path: <linux-fsdevel+bounces-348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68A7C8EE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 23:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753BA28172E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 21:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E25626293;
	Fri, 13 Oct 2023 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248824200
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 21:20:27 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736595;
	Fri, 13 Oct 2023 14:20:25 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1c9b1e3a809so19513475ad.2;
        Fri, 13 Oct 2023 14:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232025; x=1697836825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVUFHAu/2sYouE1MxKgJ7Ed5BvhxAi40Dur2aHaRFxo=;
        b=OruRU4Ex0fSwyHNSI/LDbobXFQklHAltlctNI6AJ8bk/9HlTNAp529+3t5gCV2byTu
         1IDsbpMp2+evTLaw60gepJuIzI44BR755XKea8cg0qtD9vGh9JLvJJNdmGU4DMgGhw5Y
         B8dvQSWwyvflRbukz58VoasmwpqFgEYYs4He1ZVIngYlweY1q4n6QDcAOrecXisSk3af
         +riIDqdAFd6NJ0Jy4gceFBVyH6kf++j8bbBz/N4L6f01CSnHzJ2olR2RNyVlfvvg/+RS
         PMkSl9y/xzApELhsbFe3P86DDhE3ATJur3rSkQRBnfvk19rv/7oFLOYJWYffXxPA9zsL
         qfSw==
X-Gm-Message-State: AOJu0YwK8rw6oSXDWnZUFgDwQNgyoltn8b7S8uPH4AT2rCfwi2aDUqNf
	HqkCKEZz7/NL06XIdlxoSsE=
X-Google-Smtp-Source: AGHT+IGMaA51IPk0x7pCW8F4JdKMyqzT3Q+dPbD1hFblj4gUedpX4Qp42cPYMap9ZuK83w6URwX6Ww==
X-Received: by 2002:a17:902:e74b:b0:1bb:6875:5a73 with SMTP id p11-20020a170902e74b00b001bb68755a73mr32624279plf.2.1697232025201;
        Fri, 13 Oct 2023 14:20:25 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001c5b8087fe5sm4308085pls.94.2023.10.13.14.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 14:20:24 -0700 (PDT)
Message-ID: <2f092612-eed0-4c4b-940f-48793b97b068@acm.org>
Date: Fri, 13 Oct 2023 14:20:23 -0700
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
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Avri Altman <Avri.Altman@wdc.com>,
 Bean Huo <huobean@gmail.com>, Daejun Park <daejun7.park@samsung.com>,
 Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
 <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
 <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
 <4fee2c56-7631-45d2-b709-2dadea057f52@acm.org>
 <2fa9ea51-c343-4cc2-b755-a5de024bb32f@kernel.org>
 <ZSkO8J9pD+IVaGPf@x1-carbon>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZSkO8J9pD+IVaGPf@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 02:33, Niklas Cassel wrote:
> In commit c75e707fe1aa ("block: remove the per-bio/request write hint")
> this line from fs/direct-io.c was removed:
> -       bio->bi_write_hint = dio->iocb->ki_hint;
> 
> I'm not sure why this series does not readd a similar line to set the
> lifetime (using bio_set_data_lifetime()) also for fs/direct-io.c.

It depends on how we want the user to specify the data lifetime for
direct I/O. This assignment is not modified by this patch series and
copies the data lifetime information from the ioprio bitfield from user
space into the bio:

		bio->bi_ioprio = dio->iocb->ki_ioprio;

> I still don't understand what happens if one uses io_uring to write
> to a file on a f2fs filesystem using buffered-io, with both
> inode->i_write_hint set using fcntl F_SET_RW_HINT, and bits belonging
> to life time hints set in the io_uring SQE (sqe->ioprio).

Is the documentation of the whint_mode mount option in patch 5/15 of this
series sufficient to answer the above question?

Thanks,

Bart.


