Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAEF72BBA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjFLJFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFLJEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:04:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A1D3A84;
        Mon, 12 Jun 2023 02:01:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3c5389fa2so5750535ad.0;
        Mon, 12 Jun 2023 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686560488; x=1689152488;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2dOhxKhfUBSsG4Vs+M6BHzKeDqoA0aRVHDuyDPxHPak=;
        b=Eknyg+3U3kUMbHhhsRl+FeXZ1CpNmBSKBPCdLSmsRnVSGtBjW78RO+u9qkou54P0nb
         Zddx7a4SwtDLpQE6DQbhv4B8PH03ldi+W4wgwWmE3gom/jYLf/MKrMyiIHnWISAvqWCw
         3iaGC5txqh3jDr269V9LZ7gKimXeWS9IuQzfWtTvOfXMfbJhdcILUDKP97rpwll1hANC
         IdlcGhnrNLDx2cUyxSEr0trXewIOZWcD3e1BKqz7zjNwM53bz+FKr0PuzXW2HXR5ymKY
         +pbagWsaO4S1voYaULGp0FPxEFfTdG7RiwPCISeB7i6vNO0juTognY1pMQUsv8PYB+k/
         RDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560488; x=1689152488;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dOhxKhfUBSsG4Vs+M6BHzKeDqoA0aRVHDuyDPxHPak=;
        b=CH91zfdS0ObSd6QMYmXEkwqGA4tQoa3RttCUE8ujj+W7wip+Wq5b/TuE4rErtqWh9X
         DaTuOk8FLv8fN1wszDFguTYT/UBjpGk8LQDhQYGrt8OB+0kc7zhbHtcerNf5vJ6zB9vc
         k9puCU8gV9mhyYbWpsbrfUJF8cSMVALctL5tYM+rDu21WHSpW0BqsDS0m/0rinSZ4tfb
         gIUlVm4dC+TtBmwMYEZp4rKE6ItTLSR2VYCh7PHCr/+ec4LNxbyYqsCOuHMTn8lquDqG
         7zUVD0mpX40h4fAy2y7Xdov8sxh01s4krDujs0QdXGBItvoxHgc9ite1Nb6zZYEyGoXU
         B/zg==
X-Gm-Message-State: AC+VfDzuO2MFQWg41ATpf83NpD/9wBSGHfci85JGQshNEzYeUQWhA+Z7
        Pkpe6CNQHLG5kaIS/B7x12I=
X-Google-Smtp-Source: ACHHUZ5SwQiF2Lrqr0FJsYSpkKbJj37FgBozw+7OARJLLveLqzVww9NfW+LERT+aKTqFjsk74EYA5g==
X-Received: by 2002:a17:903:41c8:b0:1b3:d759:d2dd with SMTP id u8-20020a17090341c800b001b3d759d2ddmr310524ple.9.1686560487901;
        Mon, 12 Jun 2023 02:01:27 -0700 (PDT)
Received: from dw-tp ([129.41.58.23])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902778600b001a1b66af22fsm7714350pll.62.2023.06.12.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:01:27 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:31:22 +0530
Message-Id: <87352xhx5p.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
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
In-Reply-To: <ZIa6dD5HZ6etVIe+@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sat, Jun 10, 2023 at 05:09:05PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch factors iomap_write_delalloc_punch() function out. This function
>> is resposible for actual punch out operation.
>> The reason for doing this is, to avoid deep indentation when we bring punch-out
>> of individual non-dirty blocks within a dirty folio in a later patch
>> (which adds per-block dirty status handling to iomap) to avoid delalloc block
>> leak.
>
> A bunch of overly long lines in the commit message here,
> but otherwise this looks good:

Sure. Will shorten those in next revision (considering we might need it for
some minor changes in patch-6)

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

-ritesh
