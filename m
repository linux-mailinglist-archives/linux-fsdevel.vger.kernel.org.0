Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A374E5431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 15:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbiCWO1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiCWO1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:27:24 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2244DF1C
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 07:25:52 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r8so1787960oib.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UOhEhlSweC9wQSxF5Wd7gEziwST9dg0DUvSifpkkT1Y=;
        b=eB9PgIywYvjX6brrg8B3eezCMUSkF/rg1CDY2aGsEVErobRiLt99xHDgCpG/Kb/iJC
         bGxyDnDJnkSr/AcTVM4F40a74yR/WImWRj/YY9rhX6I07bumC1+sfa4VNgfX2DOG24fP
         b3fwNzmGK/X6eyIe7nPGZd9/pOxtAuutQ8PPRJgs5eED9MpCPYKwXPHsmhse7ry4M6/x
         ln+X9ZyrZy4T83k2/ekqAAc2XjwKDRPkwlJrbjG5wp1zweH/YVGmRei5kQUUK7Yukdu+
         iIPJCNOYfC0gtelF4iIBE1UHLG/FrF1TSXw2qubZlGCruRW5VG+MIglQpJZAbhTse4kK
         nJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UOhEhlSweC9wQSxF5Wd7gEziwST9dg0DUvSifpkkT1Y=;
        b=UL7tpHUuWBmaHuw3iw2WC9e28x5K44+jh2/q6iJw3zxL+87qhxK8f+L83O0oU5fjrK
         hdI01t3sqAu7VuKyzVYUOKQ0/rqO2cmeGUeV7qr08kumlVVlp3/Szhdzp7VPJC9G5q1s
         zLXJzXu+3GeoewQEFt9gri3bCHusFvegf+xHt26wDo8C0S9COe8KHb4EI7mMGxpsqP59
         v6Y6wjxUWCnlnJFE45qpmkN9SseolQUCnS2jZ+mXYwqJ32UgT0X4Me2h2Zrxz09z0wPt
         ig3okeEVOGJ6FtNyj7On0qCM6gpultV/BkDlDXMmn5VRDXiE1s0lLEPveRpg0WsbgiH/
         6qnw==
X-Gm-Message-State: AOAM532pGoiOu6RE67TjHfLA2S3CwY2HNIdsFn0YtA7e8q2A7d2l9VVk
        bdeKOQJnXT5LQ4QEdotxpqeTo5+9jn8NBDqg6DI=
X-Google-Smtp-Source: ABdhPJywII4P7HHked3KlFIDDpBpK9SDE6N4rlP05TOaX0ZBgQq5K6qxKYnFkBBA146uzBY/MLvw6comi/xiLwKmP8s=
X-Received: by 2002:a05:6808:138d:b0:2ef:9f4b:26fe with SMTP id
 c13-20020a056808138d00b002ef9f4b26femr117785oiw.124.1648045552098; Wed, 23
 Mar 2022 07:25:52 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: dalgambdal2001@gmail.com
Received: by 2002:a8a:d85:0:0:0:0:0 with HTTP; Wed, 23 Mar 2022 07:25:51 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Wed, 23 Mar 2022 14:25:51 +0000
X-Google-Sender-Auth: twIPbGAbOFeus2JFqOvJqUczdyM
Message-ID: <CAPBbMdY59QYH7X2rH7dE7Rj6Z-d+fWkUyHcX8HKwNe=2Ova4YA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

0JfQtNGA0LDQstC10LnRgtC1LCDQv9C+0LvRg9GH0LjRhdGC0LUg0LvQuCDQtNCy0LXRgtC1INC8
0Lgg0L/RgNC10LTQuNGI0L3QuCDRgdGK0L7QsdGJ0LXQvdC40Y8/INC80L7Qu9GPINC/0YDQvtCy
0LXRgNC10YLQtSDQuA0K0LzQuCDQvtGC0LPQvtCy0L7RgNC10YLQtQ0K
