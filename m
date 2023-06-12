Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C692472C903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjFLOze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 10:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbjFLOz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:55:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259EACC;
        Mon, 12 Jun 2023 07:55:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-652d1d3e040so3319277b3a.1;
        Mon, 12 Jun 2023 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686581727; x=1689173727;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V9CIwjjScqul8Uzbw9CyqmytrTVPPn5617deb266FA8=;
        b=OJpUAmGYTTUJTSomOYm9cJLlpudVb2hVCetG0OSjNFuptnM0GK8HBiDug7+VMfj0z1
         bst3xNkN3KHT2xdv6qVNQ588+YaKF60IOznkQyMCnjFrMDQT2rC969UhhRL6I9hVLv8q
         TnW9vioUXKNnJXQA+KEOsLuVYjbKREDoz4WmPXeLCwaQB/lqXhibLDhQtOngG6fdqIuO
         JOUZR6YZ/JxCiPpc7y/iLEj1wKrClWWBTGhR+l7hIMUeOfXAA3FLnQAvfYwszwPn5Fhv
         B2/5h7wpbCTEvrp11rEyRR1lrWRLspdFV7NKLceKWfcIsPpuMJEEoroth3IG/t5ekPCq
         QuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686581727; x=1689173727;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9CIwjjScqul8Uzbw9CyqmytrTVPPn5617deb266FA8=;
        b=YQT154be0XJ/RdDdYa+EhpIxR7inKHZMPCRgaZ1fNWCZlQGhtmb+osMqXmMMztRtrP
         YHicjwiDhkOpdENAWRzWE/cvUDH/dWH50AwOdhLxXnuK8vJVveSWEl64ubBZmO5tvLUM
         mCWQGg1t2Mr5og7E5j0BAXnGv4XFKNFfFkDgakVZZj/4p+xNMdd/ujoP/ccJviEMOK0B
         sYgx04w/ke55O7VD14VxL+Ntx5QloDlrG0dADeuYI0XMeEgNkDFx+rZOX1EHbb/gXs2Q
         P2EPXfwNDENXfjHfi0vjTd+ucXzkXDhrDZRHV0I3dy8gP1VBqjdNDBa+AWCj67gNu8Is
         jnlw==
X-Gm-Message-State: AC+VfDxJUj+3aNMgrN3m2Gz65U0BjfIM3a9weqyiLf6ZiGmayeUNifgQ
        uDzwoQOfez5xCTTx08PzDgE=
X-Google-Smtp-Source: ACHHUZ6lUfZ+F8MKzU8TDnfNssoHZhb2mmnc4xLiLrA2Wfw5/9OCiMuVPj3YeIN5OzTwkj+zJqYacQ==
X-Received: by 2002:a05:6a20:104f:b0:10f:b53d:8641 with SMTP id gt15-20020a056a20104f00b0010fb53d8641mr8094377pzc.46.1686581727584;
        Mon, 12 Jun 2023 07:55:27 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b0064d3e4c7658sm7219034pfo.96.2023.06.12.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:55:27 -0700 (PDT)
Date:   Mon, 12 Jun 2023 20:25:22 +0530
Message-Id: <87r0qghgrp.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 4/6] iomap: Refactor iomap_write_delalloc_punch() function out
In-Reply-To: <20230612135658.gvukpx7567avszph@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pankaj Raghav <p.raghav@samsung.com> writes:

> Minor nit:
>
>> +static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>> +		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
>> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
>> +{
>> +	int ret = 0;
>> +
>> +	if (!folio_test_dirty(folio))
>> +		return ret;
> Either this could be changed to `goto out`
>
> OR
>
>> +
>> +	/* if dirty, punch up to offset */
>> +	if (start_byte > *punch_start_byte) {
>> +		ret = punch(inode, *punch_start_byte,
>> +				start_byte - *punch_start_byte);
>> +		if (ret)
>> +			goto out;
>
> This could be changed to `return ret` and we could get rid of the `out`
> label.

Sure, thanks Pankaj. I noted that too.
Since there is nothing in the out label. So mostly will simply return
ret. Will fix it in the next rev.

-ritesh
