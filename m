Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835E87231ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFEVKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 17:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFEVKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:10:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA0AED;
        Mon,  5 Jun 2023 14:10:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25692ff86cdso4361749a91.2;
        Mon, 05 Jun 2023 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685999405; x=1688591405;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dTAerT6LOMoebkp4msdDF6pQZZNjDf0QqcR3/BVoTV4=;
        b=bS62Pik1BnBK/sIU+mTyr3ZvDL5YklJShdv7jr/B3p3cxyc3mYsZH8ywE73IE6DOYU
         5/1ui9nr5HJ9rsMXY3Tcbo2wrc4J4StjbFw+cdKD/IYeBZGMLF9ACJl2pyr0o/T9k8/Q
         40oa61ni+3oGCWe6MMQSqRIrFAvoXPyd07MvF4VPbRCVaublfsbhSoM4K+CFmDWa+XUQ
         bWHna3pTmmNnvFVtCgBFOChDNM92FbdG2qukT4muDyQaCK/blLpsJ9efhqbH/I9tMr/L
         AVv8+OwVqMO5FTh4fkjvvQPtEWGkKZijeoewURy/xQ6UXaRSRR/U70y9NrgPkBUQ1DZD
         xiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685999405; x=1688591405;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTAerT6LOMoebkp4msdDF6pQZZNjDf0QqcR3/BVoTV4=;
        b=i4BDuAHLvVDvwqxQQ4hH0FnV1O5KM2NMkb0bLQM3SOe2qScH3kJDS2xH+8snKNa9GB
         xocvPPF5peCa59Q3D/HMKMg8DIVKVyvLZv6DdpYM2hY2BbvKTP+3FRoEGx6jRZ8rp0HC
         uJmOVS2IRJWD+fAaiDaOYkgewSidMnzXGoa4tlLeHTc+h1E16Qn/V2GLP1V9pMH9WJmm
         QWfKUDp/tK6mWxDxBdTNViiM9iVPP+wMuDlVa0JiigK5IUoe6LzwqHhovTRFNHb7Jm0d
         3COkQ4V2h/4lAgyw9IFCCcr+2qfhLwW9V5zGq5AXgdo0hxJ2M7NeY9O+hjjMEsv23MVv
         SgPw==
X-Gm-Message-State: AC+VfDxvYScCRdPpj4IQNBIgS70b67Kp5CO5cu7/BrdI+wk3UOEnvp0e
        ktUlS4xsTmE0P5PwqBU/cgkuM/iU8Ic=
X-Google-Smtp-Source: ACHHUZ6JHvd9+RdLISJgdPLCGChoT+gd2W3EDRxx2G4DLRKQ7fFDFYpzA4XKnE6fDhhZmNt2d6znXg==
X-Received: by 2002:a17:90a:1996:b0:255:c061:9e5b with SMTP id 22-20020a17090a199600b00255c0619e5bmr8360157pji.37.1685999404799;
        Mon, 05 Jun 2023 14:10:04 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id oa14-20020a17090b1bce00b002500df72713sm8264784pjb.7.2023.06.05.14.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 14:10:04 -0700 (PDT)
Date:   Tue, 06 Jun 2023 02:40:00 +0530
Message-Id: <87mt1dk447.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 3/7] iomap: Remove unnecessary test from iomap_release_folio()
In-Reply-To: <ZH0EeQmH95WoNmMc@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sun, Jun 04, 2023 at 11:01:41AM -0700, Darrick J. Wong wrote:
>> On Fri, Jun 02, 2023 at 11:24:40PM +0100, Matthew Wilcox (Oracle) wrote:
>> > The check for the folio being under writeback is unnecessary; the caller
>> > has checked this and the folio is locked, so the folio cannot be under
>> > writeback at this point.
>>
>> Do we need a debug assertion here to validate that filemap_release_folio
>> has already filtered out folios unergoing writeback?  The documentation
>> change in the next patch might be fine since you're the pagecache
>> maintainer.
>
> I don't think so?  We don't usually include asserts in filesystems that
> the VFS is living up to its promises.
>
>> >  	/*
>> > -	 * mm accommodates an old ext3 case where clean folios might
>> > -	 * not have had the dirty bit cleared.  Thus, it can send actual
>> > -	 * dirty folios to ->release_folio() via shrink_active_list();
>> > -	 * skip those here.
>> > +	 * If the folio is dirty, we refuse to release our metadata because
>> > +	 * it may be partially dirty (FIXME, add a test for that).
>>
>> Er... is this FIXME reflective of incomplete code?
>
> It's a note to Ritesh ;-)
>
> Once we have per-block dirty bits, if all the dirty bits are set, we
> can free the iomap_page without losing any information.  But I don't
> want to introduce a dependency between this and Ritesh's work.

Sure Matthew, noted.
However this looks more like an optimization which can be done for cases
where we have all bits as dirty, than a dependency.

-ritesh
