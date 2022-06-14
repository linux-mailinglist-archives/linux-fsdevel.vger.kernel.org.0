Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3BA54B048
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356959AbiFNMOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356975AbiFNMOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:14:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6FDFAA
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 05:14:14 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 93-20020a9d02e6000000b0060c252ee7a4so6405604otl.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lBFrwc11MgcaK75qf3EwNhKoIfwLYz4Dn7scEjO7Hwc=;
        b=UNA00ExpSe/IYk9qRpK3nhNY3MQGhIZVH9b+TBjq+LdlUjXIh78z6gPdY8GF0sQHK1
         HJ2n3gfPpUPhyyacfGQvRyEpF1QlynrQ30w+G5Aew5oVgyNdOMVYVhySdHNUBZObva2y
         PuLir0DHRxYshYjhyycNkTLQ7VsAQLmTK6m5EVJfcKtgRbmxa7D08ugJk7y5pLRJ/ze1
         6cL1+ieOt2sNltOPHDSKZebgxow79UdI2TUNij2cNTn50jsq9VR126vHNmWni88LExVM
         7xKsxa1nHQ7JrwK4VAXG7j0wCn6FqCQrLI4ANDOm8760jdm8KbeqIvWnFua/uGvpfZQ4
         nejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lBFrwc11MgcaK75qf3EwNhKoIfwLYz4Dn7scEjO7Hwc=;
        b=evpXq/9OdvAsQSTtnsB3+wz/foMKnN30X6macbz0hyXw3lVhCjwiYhnBnYaHGKwj/d
         sozTLp1Nllzppmv1z6uH7UwUsuiA/IzCuryN9WteK0Uiigp6ffdMDRRNwk88fM3o97P0
         QLqm14mrt/aVDMVCZ9r0LvY0qnCeMBe5nVwgXlEfVSkmRoNIjwDarz9mxabGbSVlYc3R
         jEf1ECL4d58XTWIfvgLSMNEcRb8c+nRXjcQCtKSdimWhTjf8VukhRERUbtdcGebM76gG
         efYYqWOzJ5vEZw5l99DCeq6z4j3Q0UpSfQ8e90mL2zsObOU5JF0DIja6t7jVpcSKbWp+
         wA5g==
X-Gm-Message-State: AOAM533D33nETRVZpuqPL6GPxbizXF+i7OZDL7fJaGfnfQPC55185jes
        erfSZTd9nkAPWhyXk5pyVqv2rPPIc1xCZfwIhog=
X-Google-Smtp-Source: ABdhPJxH036Sb3549Y0f3hc7Zhwns93SCbnuybCuqmcROW8sIBDtc8O0vPfU6QLql+6epoXLTxfkWaoTwfvvDQjMptA=
X-Received: by 2002:a05:6830:1691:b0:60c:1eb1:6ddf with SMTP id
 k17-20020a056830169100b0060c1eb16ddfmr1906144otr.205.1655208853785; Tue, 14
 Jun 2022 05:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:c46:0:b0:42d:ab20:ed24 with HTTP; Tue, 14 Jun 2022
 05:14:13 -0700 (PDT)
From:   Daniel Affum <danielaffum05@gmail.com>
Date:   Tue, 14 Jun 2022 15:14:13 +0300
Message-ID: <CAPkju_PQmptLCUNLrFjDqn4sN-xwFQ9XOg5Cv+KN_pd6V1aXpA@mail.gmail.com>
Subject: Confirm Receipt
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dear,

I am Daniel Affum a retired civil servant i have a  business to
discuss with you from the Eastern part of Africa aimed at agreed
percentage upon your acceptance of my hand in business and friendship.
Kindly respond to me if you are interested to partner with me for an
update.Very important.

Yours Sincerely,
Daniel Affum.
Reply to:danielaffum005@yahoo.com
