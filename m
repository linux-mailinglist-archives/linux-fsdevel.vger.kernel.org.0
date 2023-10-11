Return-Path: <linux-fsdevel+bounces-53-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB74A7C5144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2802F1C20F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC43B1DDCF;
	Wed, 11 Oct 2023 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mkk93Q4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CE1DDC1
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:13:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03758F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697022789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCk7wawpxWR/0pRF2lN6xcLeaTX+QEqqMdqYqyMN2VM=;
	b=Mkk93Q4tHi4CAuBp+cfMUQJtTGw04pPg1YC6PaZctKwWN7SGOB8MPG1rQ+2eFN9WaEVYZS
	qD1YS/DwLw7Le6nJ/L846akTYSvTaQSX8CeXGXFpVm8hhjRIFSwuW9FnNtKyliMAlJ7Lfl
	AavpS4Kcv2dgEx8Z8DsdaisZHbzJZwk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-lcEkAoiwM_WIXW9w0jpzIQ-1; Wed, 11 Oct 2023 07:13:05 -0400
X-MC-Unique: lcEkAoiwM_WIXW9w0jpzIQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53dd901c9c3so461593a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697022784; x=1697627584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCk7wawpxWR/0pRF2lN6xcLeaTX+QEqqMdqYqyMN2VM=;
        b=I4PV34A9Z9jmLr7rLD6gD4YBWa5tjaNA/qlAoNnZRNvpVRFPejg/rrAcuuB0YWrEF8
         DMCDg97goX2nJ1/b4q7yNjqsrM4z8g9R96IB2nLSTaycRJOHooqJbPHu1HmkEs6Gqi/V
         m/mhFuqEvpAv7a/xsU1bOf8NXAdBgipFeV5PUrPqbxYgR0G96A/jwLdwTnLyyxm2p7qo
         QC80S7Q2HtyBh+YwHj5tYW2gxvdBicmQ1iCQq/+zdLfFRBUAQCxDceEF6VANb2Jv9VPN
         A8SK/WdgPM/Y6WvBHH5J+KQnMjkoZVWu43AjhTDBd7+5+Xxt+Yp6CSQdINrDmMuEgHwl
         n4zA==
X-Gm-Message-State: AOJu0YyfJOTBurywltaUuICCkT7XcwJ97/8hy7YXhdI5cAg6KDTJmGzt
	pUEDHJ592MjQrtMvgFtqCCWU1kAPuLp51CCy5lPr7dVqmvTBX6Z+5DYWUUIE3nG5hYn0poE8Ql7
	BimnwPz4J/uXiKZD8PTa+c/iT
X-Received: by 2002:a05:6402:3458:b0:527:fa8d:d3ff with SMTP id l24-20020a056402345800b00527fa8dd3ffmr16817580edc.6.1697022784804;
        Wed, 11 Oct 2023 04:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM6DlOkWJnlkS9DXFMOt8lJBctYfYXrLJfXwevIGXqlKhPGtt1iOqZUje5Umfc+WHxwjEQkA==
X-Received: by 2002:a05:6402:3458:b0:527:fa8d:d3ff with SMTP id l24-20020a056402345800b00527fa8dd3ffmr16817572edc.6.1697022784532;
        Wed, 11 Oct 2023 04:13:04 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id s14-20020a056402014e00b005309eb7544fsm8696880edu.45.2023.10.11.04.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:13:04 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:13:03 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 08/28] fsverity: pass Merkle tree block size to
 ->read_merkle_tree_page()
Message-ID: <y3cj7zsuhdybwk4f6sfxlx52srhtwgetu4updcxe7fqex7w7sr@6qyxm5blq3qs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-9-aalbersh@redhat.com>
 <20231011031712.GC1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011031712.GC1185@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 20:17:12, Eric Biggers wrote:
> XFS doesn't actually use this, though.  In patch 10 you add
> read_merkle_tree_block, and that is used instead.
> 
> So this patch seems unnecessary.

True, will drop this one.

-- 
- Andrey


