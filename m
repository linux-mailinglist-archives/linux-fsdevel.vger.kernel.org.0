Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD16CB205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 00:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjC0WzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0WzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:55:03 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F981FF3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 15:54:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bj20so7644100oib.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679957676;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gce4jAm2VQ+4/NN1bEb3Xa3pCNNcaq/EMTsiIRs6ukc=;
        b=h4Wc7/Vy6xaZa+KITffXOcOMDMwA8DTJX2K+i0GLpPdHwGPhXb3C2YzH7jkZFb7ZRD
         VA8mzy1Jli0LOSR3AR6gaD2583P9MaDxVd5OI/3QTdkn8Tov93O/CaVGVPgmMxn7ENcW
         JD4h1twOgIQvOYWwVTD1KW5YqGf2/INRXN80I46HbGx22Uqb3BQRLK7gTbtvmhjgaOv3
         M1V9RakZ/6Wf8n6pfX74PblCxQOTmB4gDzQjjt34nuJ+MeJej2vSt+XSS/rDh/mlQp9v
         aBicDtpC1I9Ll89J2vjAmJGtIB4QEWcUcFvr0GPLSrI+ZaOlQGagqBRurEq3tCwFVADS
         hGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679957676;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gce4jAm2VQ+4/NN1bEb3Xa3pCNNcaq/EMTsiIRs6ukc=;
        b=6hj7wf24inApQCfLtjarwV5nRHs8cyaFFn68jffYPoWFPCtFh/M7jmhQK5NsfKlUgC
         KXGa4sxwI0dIGyfLGC6WtF3aZMLWIyFYnoAxbFIrsQiF/CbunSqk/cOyf/xj2iCX7gbc
         L6vufH35StAgcNNAcXsDcFRh3Qd2PxSLvpG5YrOlp79yfnb/zJ5vPJ92J2UGzKRb8h7v
         TyDwd5LZ3KPFqEuPpP+du7cd1qB7S7y9cqOS2L3gbFpOq6YbSEJ6K4onjkmoPXxZvLrV
         YWQXNOndZ40BDk5+02joyJyy1MPF7xqLmkCasNDH62VgOBqXMycfdhKhx3mPRihDjRCw
         b+WA==
X-Gm-Message-State: AO0yUKUmMagAy4n6lST5oxF+8G8RYcGhVy7Y95xn/I6QqGLWBgam3U20
        jZaZSERrByETyziaGgokGuvVf/+KhDWiZ2S7vk0=
X-Google-Smtp-Source: AK7set/MJQkDKLOQh3o1sT3CGGlxs/916R1AQNEf4yDhswbg1q7VdCzCPFHhTFiBCUk933wTUaH0tw==
X-Received: by 2002:a54:440f:0:b0:386:ee2f:86e7 with SMTP id k15-20020a54440f000000b00386ee2f86e7mr5624796oiw.10.1679957676217;
        Mon, 27 Mar 2023 15:54:36 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id u63-20020a4a5742000000b0051aa196ac82sm11992049ooa.14.2023.03.27.15.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2023 15:54:35 -0700 (PDT)
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: memcpy_page, memcpy_to/from_page, memset_page and folio based methods
Message-Id: <37204555-64AE-49B8-A030-60CF54940BDC@bytedance.com>
Date:   Mon, 27 Mar 2023 15:54:23 -0700
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I am trying to exchange memcpy_page(), memcpy_to/from_page(), =
memset_page() methods
on folio based methods in SSDFS code. But I can see only =
memcpy_from_file_folio().
I definitely could miss the related discussion. But why don't we have =
the complete
family of methods for folio case? Any restrictions? Do we have plan to =
add these
methods?

Thanks,
Slava.

