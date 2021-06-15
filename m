Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4C3A89FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFOUOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:14:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05CFC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 13:12:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so2582370wmq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAVl+fs3B/lGFP9rKvHgWY8cF7LQHnDZpQEbEEvSoLI=;
        b=mkMCQJmwbDQ45bHyE49/5MVU5F3C8ah2I/kNoZFrRuEU57pKfZFDIiEigQcE1G/TE1
         5Ud7cb6cuoYe8oHGHqYFk9y+2GmqcJjZ58WB6VuQz5EPjD+bioZ11WXgaYa5PsjJNGOJ
         SriHnRYlhbWG7BVXlxcpX/RbncGuGMoqVfLTqYH1BQgUaI8lV8afCQUJc4oKDpjc41To
         quNwNvPbbjqIOk0SeC0pNo7bE2ZM5WrNaktx4pLX/sc035PWokmPvAATmdBF72mmi52e
         0kc7r23Jjm4JNgvdacBlYNm85nVXSZlzbWgI0axJjg7lra22+dPhjqWcxTCHoDz2PqiY
         rYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAVl+fs3B/lGFP9rKvHgWY8cF7LQHnDZpQEbEEvSoLI=;
        b=LwEr18GjcMLqgFA+srdR7ytXajVfVAbNfZfcuc9MXL2VfgEBc6r1fSQ+xgFxLI/GLY
         Z7LiiT7x3w/qaSmw/OseXmgUeNYHTPvcxn+b2+zc7KAfGBlnONAb12ObIbgmPBGaBrSG
         a1dZhwRsWjvQA7eb+ejXbXdVt9G+uMq0o1nGDcjsWWTGrvZBVijdheN0tqjGqTKgjn+a
         FB+Ii7qnjE77gVE7P27IUfYENAj1S0cOK8XfhA8Ae1JAmJGeDM9C6oqGPbnC9zVG9O5D
         cR/tcoNp+AqXG8XbYnRQ5AgDv95Cjeod31R7Dm/uHHq1UrBe38urOaW5F1CRApPJsHh3
         SdGA==
X-Gm-Message-State: AOAM532Ichb3ApVfw4d5hhOGJwrI7INRtsFqq1A7MdCbk8Fd2t5koMGn
        3Pmx3vYjxpB68JDVCXQSHfkj1/57NrtoVG+vfA==
X-Google-Smtp-Source: ABdhPJy07gEOjrprsP0CljABI1Zk0yWuS3pjhwv1YgMl+BebQxlm/0xPkR5L1msXEyyEzs1Uc+ayTwS4/K6VsXnGQsw=
X-Received: by 2002:a7b:c041:: with SMTP id u1mr1075759wmc.95.1623787919280;
 Tue, 15 Jun 2021 13:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANXojcxGPS-3CqCNx3MuwtHBsu+tD2RFWszD7qcRMn2wZkANZw@mail.gmail.com>
 <BYAPR04MB49653F0A26E0F40C2357FAE886309@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49653F0A26E0F40C2357FAE886309@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Stef Bon <stefbon@gmail.com>
Date:   Tue, 15 Jun 2021 22:11:48 +0200
Message-ID: <CANXojcxNEt_EccOiNj=Dg5aUFvB8sPdyP4wj3OUDG7qjMJ7ZbQ@mail.gmail.com>
Subject: Re: Tests available for list implementation.
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, I want to test it first before I write a patch.

S.J. Bon
