Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12877D096
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbjHORHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbjHORG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:06:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FE1737
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 10:06:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb91c20602so10008645ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692119218; x=1692724018;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KunTLCDFdnFV6ba8aEeNGrWDoHIvATT0giWpzqgoFyM=;
        b=OQC60GxAWSKbraGDjTOlWKwhpOBtD9EFlz4r4f1cV2eLiB/9xQlOcMtzA1xC3WpPMq
         APFrQ8BDDVCbPs5/cDc4v8LS1CL5bC89DIRpah0gS3lpRvR4EzYAYaUFe8e2Axm8a0d9
         9w4lzKCzoNru0306gJWhnw2PGSWqg+diKELT4GviNUG8wqXHy0VhL3EJeDSh22r5YADn
         M95rvwpGkvwYEPiUadVxf2wpvsYo8LFriQHONw8aAY9hnXz/YYgD6OGsWtzHwRuDbcW+
         MD2Ec5+Gip6qKAFyz12rGpHY+zrUpLmy52/CXkB4IOrZemwwwaOuktI8LOCbQMdZjvmp
         7j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692119218; x=1692724018;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KunTLCDFdnFV6ba8aEeNGrWDoHIvATT0giWpzqgoFyM=;
        b=CGSosiwuBAbc5R1c7z1+loY5jTQKa6JwV/SZaUvIe3O+fYdKviQg7wYqxxOPn48bsQ
         eES1UX18fLks4bTvKxYW7x6GANIZ4CPgQiao8IJEQ5tUr53jpPFeLR2EZaVaherKLgKJ
         n+aOqF5f0o0PfrE2R3YnUpdGk2ednXJKhrUu/SuGWB3vEiWOBBNbGjxl93a0YrOhqhVs
         I/ZO/EzyxTZN01c8iV2u3B8j1GCbe6R7KhXW1wmCNNYpygX+HEJAZuMT62agNN1Mc2or
         ZohTROC8VG5z6Y/1kI4ATPFiTX5OUyNScTYUMJlR3/SYEjnVk582BZZ9NQB+N2odv3Jr
         ONaQ==
X-Gm-Message-State: AOJu0YypTlkQdXzo75YLrOUCeglnavI6K/r2MpZlzr8JKJZGtHSFhsH5
        F/kDWXZEglJg2tnAI9THWY0gcA==
X-Google-Smtp-Source: AGHT+IFZjQBiccLkwuQvNFwHhtbMVeYOajYZilmdfzNv1CyCyuzc1KVclxUa2VGn8/LssuDpzp3uSg==
X-Received: by 2002:a17:902:e5c8:b0:1bb:83ec:832 with SMTP id u8-20020a170902e5c800b001bb83ec0832mr15187942plf.2.1692119218214;
        Tue, 15 Aug 2023 10:06:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001bdccf6b8c9sm6677257plj.127.2023.08.15.10.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 10:06:57 -0700 (PDT)
Message-ID: <12490760-d3fe-4b9d-b726-be2506eff30b@kernel.dk>
Date:   Tue, 15 Aug 2023 11:06:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: create kiocb_{start,end}_write() helpers
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20230815165721.821906-1-amir73il@gmail.com>
 <d8013748-f5ec-47c9-b4ba-75538b7ac93d@kernel.dk>
In-Reply-To: <d8013748-f5ec-47c9-b4ba-75538b7ac93d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/23 11:02 AM, Jens Axboe wrote:
> On 8/15/23 10:57 AM, Amir Goldstein wrote:
>> +/**
>> + * kiocb_start_write - get write access to a superblock for async file io
>> + * @iocb: the io context we want to submit the write with
>> + *
>> + * This is a variant of file_start_write() for async io submission.
>> + * Should be matched with a call to kiocb_end_write().
>> + */
>> +static inline void kiocb_start_write(struct kiocb *iocb)
>> +{
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +
>> +	iocb->ki_flags |= IOCB_WRITE;
>> +	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
>> +		return;
>> +	if (!S_ISREG(inode->i_mode))
>> +		return;
>> +	sb_start_write(inode->i_sb);
>> +	/*
>> +	 * Fool lockdep by telling it the lock got released so that it
>> +	 * doesn't complain about the held lock when we return to userspace.
>> +	 */
>> +	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
>> +	iocb->ki_flags |= IOCB_WRITE_STARTED;
>> +}
>> +
>> +/**
>> + * kiocb_end_write - drop write access to a superblock after async file io
>> + * @iocb: the io context we sumbitted the write with
>> + *
>> + * Should be matched with a call to kiocb_start_write().
>> + */
>> +static inline void kiocb_end_write(struct kiocb *iocb)
>> +{
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +
>> +	if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
>> +		return;
>> +	if (!S_ISREG(inode->i_mode))
>> +		return;

And how would IOCB_WRITE_STARTED ever be set, if S_ISREG() isn't true?

-- 
Jens Axboe

