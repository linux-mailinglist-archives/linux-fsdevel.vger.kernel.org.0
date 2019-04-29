Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20576ECF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfD2Wvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:51:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41033 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfD2Wvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:51:42 -0400
Received: by mail-io1-f67.google.com with SMTP id r10so10495896ioc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2019 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOFgUAJuLCZIFVS5UFU3pChkm/oJTH8xTrANxZtZZ9c=;
        b=I9xAjpCVFtrr4DWGiYXXRhWTL+N1r+wgw3/oE3PcmjHVcO6GGvdn9P++tsCKVW15Zg
         hb2RezqGxUNCuvPsKky0o1uZDJ+iBdVQ1tUwD+RMR5ekp75sBE19GvZWtoYW6vEacSku
         LY8RoWvm8iZHLAn6ZsHTTZfNIgaCLmPNBfWsFPeQbl3s7X2jNXFNK4HIZ/fXnw+DyN3Y
         +JhD6kloODe83crEs8slvY5TO8oa9ulx8sYNEvTzGxXX58afRiqJL7D4++y8D3ZwGPh1
         ndJ90tW3l0DskrBy/u4yj7OywticnKYbieTQDUYix6LDwQmM2E1BoqzYdnSxMdVY6EW4
         c+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOFgUAJuLCZIFVS5UFU3pChkm/oJTH8xTrANxZtZZ9c=;
        b=PPaHsPcAq34PBzT4DQ/C0AH5FgrZAV7Pfi0AXrh0ttd21VYBrAh4/RphB5llKMOUgx
         CRi/IOFynMV6hYlztUjjY0KHLViW73ipzAw/IgSS1hZ46f3nziqEgVzLBnVK0u3tMPtX
         HmRrk9ywSLz0FgW4R2RGHqfM6URudmZImqd+eiJNVEypWjR4bRtLfUwYuDHF1jxwjIxo
         iRBhQPjtz+onHqUtHj9fHfvBp6L+eqQ65RKwAFnKU9PVkIIrOvaGk0kLmS7BNqfA9ZAW
         +pz2I/j7NdZDy4MUNEKK6ijO76asajsjpxLGhFJwt3vHaykKsFUVyD61vq0CxWcudTQE
         mgvA==
X-Gm-Message-State: APjAAAVMu7y81Hpq9hQ8yBLwMQtyMjZ0vBv2o3WRgnvrTT0jxAgWncZ9
        34x+KrY+cRHzRfHJ4gyRJCKbK1HkhBoNTcKiVD5SNQ==
X-Google-Smtp-Source: APXvYqzbleURmo1MUprct2Hk5toEDFWPq8KkObP3aqOAMhy++LvzH8IKFOypg06xx0N1IdSA6LM0RBBVUfNNKyJ34x4=
X-Received: by 2002:a6b:c842:: with SMTP id y63mr168434iof.304.1556578301455;
 Mon, 29 Apr 2019 15:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com> <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
 <1551911937.31706.217.camel@linux.ibm.com> <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
 <1551923650.31706.258.camel@linux.ibm.com> <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
 <1551991690.31706.416.camel@linux.ibm.com> <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
 <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
 <1554416328.24612.11.camel@HansenPartnership.com> <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
 <1554417315.24612.15.camel@HansenPartnership.com> <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
 <1554431217.24612.37.camel@HansenPartnership.com> <CACdnJut_vN9pJXq-j9fEO1CFZ-Aq83cO2LiFmep=Fn9_NOKhWQ@mail.gmail.com>
In-Reply-To: <CACdnJut_vN9pJXq-j9fEO1CFZ-Aq83cO2LiFmep=Fn9_NOKhWQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Apr 2019 15:51:30 -0700
Message-ID: <CACdnJusKM74vZ=zg+0fe50gNRVaDPCdw9mfbbq45yTqnZfZX5w@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mimi, anything else I can do here?
