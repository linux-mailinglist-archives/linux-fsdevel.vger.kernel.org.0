Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED338725BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbjFGKoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 06:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjFGKo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:44:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B7124;
        Wed,  7 Jun 2023 03:44:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b075e13a5eso62914765ad.3;
        Wed, 07 Jun 2023 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686134666; x=1688726666;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUmmndzzfjBksj76GBgKS0Ti0TYytinvVXM6hqmaeD8=;
        b=Bqf0uhuAbb2Xzpuiv8aU0PizjNYjJr+uhKrlSVfmlJRjUqorHUGrISTLP+xZg6gBEO
         41wKbGeH67P5jnRsru0pMZN7DanF0DspJUtpifDViVMOUG659hZvAV3G0jF5CxF3mrLR
         mAwT5KyfHVCuvOsCBzPEWknvMoYU7uyVA1a+rqOzpMl2h8TyLH2X2NAF0Smoku5OWYHW
         jQdKbsWqfSKzVSpe3FeTX4Wqj/ZYQ32HK8Tb3JmfOFW/FltACL3SfgHur83IZNUGiccJ
         1MBZL/EkPHmvrs1lXn7g6x1da/1Fe0XflNYR/qkoRlm20w5XPDQUoqtr7kUQaQwsBJm8
         0IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134666; x=1688726666;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUmmndzzfjBksj76GBgKS0Ti0TYytinvVXM6hqmaeD8=;
        b=ikZQhp+rp+IpYZvflVoDnumra9U+2sO08IsE+t46frt5khQW/R6gsOvSLbJhEOBVwb
         QPTTsDNDvRw6aqHfDqvNavmAgvxM1/81C12ye1Mg9EEwH2EJW6SNhmENE4gJhIEbVfaz
         Q56wxSFOazTdXSmbCasSlhJX2A3B2d/gVHS+275PvsxKoCMIRuEDgAck9GZlsZsvtj0E
         nph0EeiXXakHCgyIAzpTqYz2n8aRnb5IbQhzIBYtxSSIsSUipUDz2eWnTozl3/G2mo+1
         6jsbOLMPPHaUc2Hd8msk9iORgqnwNk3E9BHP3WcOR6fX/kqg0IVg8zXNmaT8ivpBXdBt
         JzTA==
X-Gm-Message-State: AC+VfDzJ8GeEi0SWMn/v8MiMcsT7plsHILgfDUtxV1e6F2ii0EVEk29u
        WA0LZ0sO+GSdEHkLmhK/WgOHkIGdPJs=
X-Google-Smtp-Source: ACHHUZ7DwmRF+wW3koA2mnP63Y8N2+MgSw/WC4aXWFzds5+AtXMzkjuua0NWJ+2vII0Pdw04YbLtOQ==
X-Received: by 2002:a17:902:d2c3:b0:1ab:253e:6906 with SMTP id n3-20020a170902d2c300b001ab253e6906mr4983073plc.67.1686134666462;
        Wed, 07 Jun 2023 03:44:26 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709028f9300b001b02713a301sm10123893plo.181.2023.06.07.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:44:26 -0700 (PDT)
Date:   Wed, 07 Jun 2023 16:14:21 +0530
Message-Id: <87wn0fimbe.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 2/5] iomap: Renames and refactor iomap_folio state bitmap handling
In-Reply-To: <ZIAouOHobxGXUk5j@infradead.org>
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

> On Tue, Jun 06, 2023 at 05:13:49PM +0530, Ritesh Harjani (IBM) wrote:
>> Also refactors and adds iof->state handling functions for uptodate
>> state.
>
> What does this mean?

It is this part.

+static inline bool iomap_iof_is_fully_uptodate(struct folio *folio,
+					       struct iomap_folio *iof)

+static inline bool iomap_iof_is_block_uptodate(struct iomap_folio *iof,
+					       unsigned int block)

+static void iomap_iof_set_range_uptodate(struct folio *folio,
+			struct iomap_folio *iof, size_t off, size_t len)

+static void iomap_set_range_uptodate(struct folio *folio, size_t off,
+				     size_t len)


> And please don't mix renames and other changes in
> a single patch.

All of this is related to uptodate bitmap handling code.
i.e.
- Renaming "uptodate" bitmap to "state" bitmap in struct iomap_page.
- Renaming "uptodate_lock" to "state_lock" in struct iomap_page
- Adding helper routines for uptodate bitmap handling
- A small refactoring of iomap_set_range_uptodate() function to drop
"iop" as a function argument. And move it's function definition above iomap_iof_alloc()


Ok, so would you prefer if this has been split into 3 seperate patches?

1. Renaming of uptodate and uptodate_lock to state and state_Lock.
2. Refactor iomap_set_range_uptodate() function to drop struct
iomap_page from it's argument and move it above iomap_iof_alloc() (or
iomap_ibs_alloc or iomap_fbs_alloc whichever name we settle with)
3. Add uptodate bitmap helper routines e.g.
iomap_iof_is_block_uptodate(), iomap_iof_is_fully_uptodate().

-ritesh
